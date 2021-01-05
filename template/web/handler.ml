let list req =
  let open Lwt.Syntax in
  let csrf = Sihl.Web.Csrf.find req in
  let* todos, _ = Todo.search 100 in
  Lwt.return @@ Opium.Response.of_html (Template.todo_list csrf todos)
;;

let update req =
  let open Lwt.Syntax in
  let id = Opium.Router.param req "id" in
  match Sihl.Web.Form.find_all req with
  | [ ("description", [ description ]) ] ->
    let* () = Todo.update id ~description in
    let resp = Opium.Response.redirect_to "/site/todos/" in
    Lwt.return @@ Sihl.Web.Flash.set (Some "Successfully updated") resp
  | _ ->
    let resp = Opium.Response.redirect_to "/site/todos/" in
    Lwt.return @@ Sihl.Web.Flash.set (Some "Failed to update todo description") resp
;;

let do_ req =
  let open Lwt.Syntax in
  let id = Opium.Router.param req "id" in
  let* () = Todo.do_ id in
  let resp = Opium.Response.redirect_to "/site/todos/" in
  Lwt.return @@ Sihl.Web.Flash.set (Some "Successfully set to done") resp
;;
