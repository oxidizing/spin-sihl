(* Site routes *)
let list_todos = Sihl.Web.Http.get "/" Handler.list
let add_todos = Sihl.Web.Http.post "/add" Handler.add
let do_todos = Sihl.Web.Http.post "/do" Handler.do_

let site_router =
  Sihl.Web.Http.router
    ~middlewares:(Middleware.site ())
    ~scope:"/"
    [ list_todos; add_todos; do_todos ]
;;

(* The list of routers that can be passed to the HTTP service *)
let all = [ site_router ]
