let getUser = async () => {
  open Fetch

  let apiUrl = Js.Option.getWithDefault("", Env.apiUrl)
  let response = await fetch(
    apiUrl ++ "/portal/me",
    {headers: Headers.fromObject({"content-type": "application/json"})},
  )

  await response->Response.json
}

let getGraph = async (id: string) => {
  open Fetch

  let apiUrl = Js.Option.getWithDefault("", Env.apiUrl)
  let response = await fetch(
    apiUrl ++ "/graph/" ++ id,
    {headers: Headers.fromObject({"content-type": "application/json"})},
  )

  await response->Response.json
}
