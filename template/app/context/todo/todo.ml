let cleaner = Repo.clean

let create description =
  let todo = Model.create description in
  Repo.insert todo
;;

let find id = Repo.find id

let update id ~description =
  let open Lwt.Syntax in
  let* todo = find id in
  let updated = Model.{ todo with description } in
  Repo.update updated
;;

let do_ id =
  let open Lwt.Syntax in
  let* todo = find id in
  let updated = Model.{ todo with status = Done } in
  Repo.update updated
;;

let search ?(sort = `Desc) ?filter limit = Repo.search sort filter limit
