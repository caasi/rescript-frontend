FROM node:16-alpine

WORKDIR /usr/src/app

# the rescript compiler should not depend on ninja in the future
# see: https://github.com/rescript-lang/rescript-compiler/issues/5179
RUN apk add --no-cache g++ make python2

COPY . ./
RUN yarn

# `yarn start` failed to listen to file changes so we just start vite instead
ENTRYPOINT ./start.sh yarn start:vi