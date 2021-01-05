(* Site routes *)
let todos = Sihl.Web.Http.get "/todos" Handler.list
let update = Sihl.Web.Http.post "/todos/:id" Handler.update
let do_ = Sihl.Web.Http.post "/todos/:id/do" Handler.do_

let site_router =
  Sihl.Web.Http.router
    ~middlewares:(Middleware.site ())
    ~scope:"/site"
    [ todos; update; do_ ]
;;

(* The list of routers that can be passed to the HTTP service *)
let all = [ site_router ]
