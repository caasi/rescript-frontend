%%raw("import './App.css'")

@react.component
let make = () => {
  let mainRef = React.useRef(Js.Nullable.null)
  let graphAppRef = React.useRef(None)
  let (user, setUser) = React.useState(() => User.empty)

  React.useEffect0(() => {
    switch mainRef.current->Js.Nullable.toOption {
    | Some(element) => {
        let app = GraphApp.initialize(element)
        graphAppRef.current = Some(app)
      }
    | None => ()
    }

    Some(
      () => {
        switch mainRef.current->Js.Nullable.toOption {
        | Some(element) =>
          switch graphAppRef.current {
          | Some(graphApp) => {
              graphApp->GraphApp.destroy(element)
              graphAppRef.current = None
            }
          | None => ()
          }
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

  React.useEffect0(() => {
    let _ = Api.getGraph("f3e28676-a06e-424a-b143-a8470837fe0f")->Js.Promise2.then(data => {
      switch data->Json.decode(Graph.Decode.graph) {
      | Ok(graph) =>
        switch graphAppRef.current {
        | Some(graphApp) => {
            let _ = graphApp->GraphApp.setData(graph)
          }
        | None => ()
        }
      | Error(err) => Js.log(err)
      }
      Js.Promise.resolve()
    })
    None
  })

  <div className="app">
    <main ref={ReactDOM.Ref.domRef(mainRef)} />
  </div>
}
