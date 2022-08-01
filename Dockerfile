FROM node:16-alpine

WORKDIR /usr/src/app

# the rescript compiler should not depend on ninja in the future
# see: https://github.com/rescript-lang/rescript-compiler/issues/5179
RUN apk add --no-cache g++ make python3
# Alpine removed python2 since 3.12.0
# see: https://wiki.alpinelinux.org/wiki/Release_Notes_for_Alpine_3.12.0
RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

COPY . ./
RUN yarn

# `yarn start` failed to listen to file changes so we just start vite instead
ENTRYPOINT ./start.sh yarn start:vi