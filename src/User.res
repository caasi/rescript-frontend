type t = {firstname: string, lastname: string}

module Decode = {
  open Json.Decode

  let user = object(field => {
    firstname: field.required(. "firstname", string),
    lastname: field.required(. "lastname", string),
  })
}

let empty: t = {
  firstname: "",
  lastname: "",
}

let name = (user: t) =>
  if user.firstname == "" && user.lastname == "" {
    None
  } else if user.firstname == "" {
    Some(user.lastname)
  } else if user.lastname == "" {
    Some(user.firstname)
  } else {
    Some(user.firstname ++ " " ++ user.lastname)
  }
