type t

@module("./graph") external initialize: Dom.element => t = "initialize"

@module("./graph") external destroy: (t, Dom.element) => unit = "destroy"

@module("./graph") external resize: (t, float, float) => t = "resize"

@module("./graph") external setData: (t, Graph.t) => t = "setData"
