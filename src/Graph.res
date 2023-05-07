type t = {
  id: string,
  name: string,
  owner: string,
  nodes: array<Node.t>,
  links: array<Link.t>,
}

module Decode = {
  open Json.Decode

  let graph = object(field => {
    id: field.required(. "id", string),
    name: field.required(. "name", string),
    owner: field.required(. "owner", string),
    nodes: field.required(. "nodes", array(Node.Decode.node)),
    links: field.required(. "links", array(Link.Decode.link)),
  })
}
