type t = {
  id: string,
  label: string,
  x: float,
  y: float,
}

module Decode = {
  open Json.Decode

  let node = object(field => {
    id: field.required(. "id", string),
    label: field.required(. "label", string),
    x: field.required(. "x", float),
    y: field.required(. "y", float),
  })
}
