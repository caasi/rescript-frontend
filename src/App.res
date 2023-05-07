%%raw("import './App.css'")

@react.component
let make = () => {
  let headerRef = React.useRef(Js.Nullable.null)
  let (user, setUser) = React.useState(() => User.empty)

  React.useEffect0(() => {
    switch headerRef.current->Js.Nullable.toOption {
    | Some(element) => GraphApp.initialize(element)
    | None => ()
    }

    Some(
      () => {
        switch headerRef.current->Js.Nullable.toOption {
        | Some(element) => GraphApp.destroy(element)
        | None => ()
        }
      },
    )
  })

  React.useEffect0(() => {
    let _ = Api.getUser()->Js.Promise2.then(data => {
      switch data->Json.decode(User.Decode.user) {
      | Ok(user) => setUser(_ => user)
      | Error(err) => Js.log(err)
      }
      Js.Promise.resolve()
    })
    None
  })

  <div className="app">
    <header ref={ReactDOM.Ref.domRef(headerRef)} />
    <main>
      <p>
        {switch user->User.name {
        | Some(name) => React.string(`Hello, ${name}! `)
        | None => React.string("Hello! ")
        }}
        {React.string("Edit")}
        <code> {React.string("src/App.res")} </code>
        {React.string("and save to reload.")}
      </p>
    </main>
    <footer>
      <a href="https://rescript-lang.org/" target="_blank" rel="noopener noreferrer">
        {React.string("Learn ReScript")}
      </a>
      <span className="separator"> {React.string("|")} </span>
      <a href="https://vitejs.dev/" target="_blank" rel="noopener noreferrer">
        {React.string("Learn Vite")}
      </a>
      <span className="separator"> {React.string("|")} </span>
      <a href="https://prettier.io/" target="_blank" rel="noopener noreferrer">
        {React.string("Learn Prettier")}
      </a>
    </footer>
  </div>
}
