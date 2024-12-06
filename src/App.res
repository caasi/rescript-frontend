open Webapi

%%raw("import './App.css'")

@react.component
let make = () => {
  let mainRef = React.useRef(Js.Nullable.null)
  let graphAppRef = React.useRef(None)
  let (_, setUser) = React.useState(() => User.empty)
  let (isLoading, setIsLoading) = React.useState(() => false)
  let (error, setError) = React.useState(() => None)

  React.useEffect(() => {
    // initialize graph app
    switch mainRef.current->Js.Nullable.toOption {
    | Some(element) => {
        let app = GraphApp.initialize(element)
        graphAppRef.current = Some(app)
      }
    | None => ()
    }

    // observe container size
    let resizeObserver = ResizeObserver.make(entries => {
      entries->Array.forEach(
        entry => {
          switch graphAppRef.current {
          | Some(graphApp) => {
              let rect = entry->ResizeObserver.ResizeObserverEntry.contentRect
              let _ = graphApp->GraphApp.resize(rect->Dom.DomRect.width, rect->Dom.DomRect.height)
            }
          | None => ()
          }
        },
      )
    })
    switch mainRef.current->Js.Nullable.toOption {
    | Some(element) => {
        let _ = resizeObserver->Webapi.ResizeObserver.observe(element)
      }
    | None => ()
    }

    // cleanup
    Some(
      () => {
        switch mainRef.current->Js.Nullable.toOption {
        | Some(element) =>
          resizeObserver->Webapi.ResizeObserver.unobserve(element)
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
  }, [])

  React.useEffect(() => {
    setIsLoading(_ => true)
    setError(_ => None)
    
    let _ = Api.getUser()->Js.Promise2.then(data => {
      switch data->Json.decode(User.Decode.user) {
      | Ok(user) => setUser(_ => user)
      | Error(err) => setError(_ => Some(err))
      }
      setIsLoading(_ => false)
      Js.Promise.resolve()
    })->Js.Promise2.catch(err => {
      setError(_ => Some(err->Js.String2.make))
      setIsLoading(_ => false)
      Js.Promise.resolve()
    })
    None
  }, [])

  React.useEffect(() => {
    setIsLoading(_ => true)
    setError(_ => None)
    
    let _ = Api.getGraph("f3e28676-a06e-424a-b143-a8470837fe0f")->Js.Promise2.then(data => {
      switch data->Json.decode(Graph.Decode.graph) {
      | Ok(graph) =>
        switch graphAppRef.current {
        | Some(graphApp) => {
            let _ = graphApp->GraphApp.setData(graph)
          }
        | None => setError(_ => Some("Graph app not initialized"))
        }
      | Error(err) => setError(_ => Some(err))
      }
      setIsLoading(_ => false)
      Js.Promise.resolve()
    })->Js.Promise2.catch(err => {
      setError(_ => Some(err->Js.String2.make))
      setIsLoading(_ => false)
      Js.Promise.resolve()
    })
    None
  }, [])

  <main className="app" ref={ReactDOM.Ref.domRef(mainRef)}>
    {switch (isLoading, error) {
    | (true, _) => React.string("Loading...")
    | (false, Some(err)) => <div className="error"> {React.string(err)} </div>
    | (false, None) => React.null
    }}
  </main>
}
