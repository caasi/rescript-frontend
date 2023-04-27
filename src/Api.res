let getUser = async () => {
  open Fetch

  let apiUrl = Js.Option.getWithDefault("", Env.apiUrl)
  let response = await fetch(
    apiUrl ++ "/portal/me",
    {headers: Headers.fromObject({"content-type": "application/json"})},
  )

  await response->Response.json
}
