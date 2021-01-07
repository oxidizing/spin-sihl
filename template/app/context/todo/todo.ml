(* The service provides functionality to the outside world and is the main
   entry point to the "todo" context.

   Once a request makes it to the service, we can safely assume that the request   has been validated and authorized. Business rules that can not be placed
   in the model go here. The service calls models and repositories.
*)

module Model = Model

let cleaner = Repo.clean

let create description =
  let todo = Model.create description in
  Repo.insert todo
;;

let find id = Repo.find id

let do_ id =
  let open Lwt.Syntax in
  let* todo = find id in
  let updated = Model.{ todo with status = Done } in
  Repo.update updated
;;

let search ?(sort = `Desc) ?filter limit = Repo.search sort filter limit
