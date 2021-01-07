(* All the HTTP entry points are listed here as routes.

   Don't put actual logic here to keep it declarative and easy to read.
   The overall scope of the web app should be clear after scanning the routes.
*)

let list_todos = Sihl.Web.Http.get "/" Handler.list
let add_todos = Sihl.Web.Http.post "/add" Handler.add
let do_todos = Sihl.Web.Http.post "/do" Handler.do_

let site_router =
  Sihl.Web.Http.router
    ~middlewares:(Middleware.site ())
    ~scope:"/"
    [ list_todos; add_todos; do_todos ]
;;

(* The list of routers is used by the HTTP service that is configured in run.ml. *)
let all = [ site_router ]
