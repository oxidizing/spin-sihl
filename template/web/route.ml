(* Site routes *)
let todos_site = Sihl.Web.Http.get "/todos" Handler.list
let update_todo_site = Sihl.Web.Http.post "/todos/:id" Handler.update
let do_todo_site = Sihl.Web.Http.post "/todos/:id/do" Handler.do_
let cancel_todo_site = Sihl.Web.Http.post "/todos/:id/cancel" Handler.cancel

let site_router =
  Sihl.Web.Http.router
    ~middlewares:(Middleware.site ())
    ~scope:"/site"
    [ todos_site; update_todo_site; do_todo_site; cancel_todo_site ]
;;

(* The list of routers that can be passed to the HTTP service *)
let all = [ site_router ]
