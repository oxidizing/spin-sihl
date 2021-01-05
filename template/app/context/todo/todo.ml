let cleaner = Repo.clean

let create description =
  let todo = Model.create description in
  Repo.insert todo
;;

let find id = Repo.find id
let update todo = Repo.update todo
let search ?(sort = `Desc) ?filter limit = Repo.search sort filter limit
