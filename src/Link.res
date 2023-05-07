type t = {
  id: string,
  label: string,
  src: string,
  dst: string,
}

module Decode = {
  open Json.Decode

  let link = object(field => {
    id: field.required(. "id", string),
    label: field.required(. "label", string),
    src: field.required(. "src", string),
    dst: field.required(. "dst", string),
  })
}
