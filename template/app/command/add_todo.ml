let run =
  Sihl.Command.make
    ~name:"add-todo"
    ~help:"<todo description>"
    ~description:"Adds a new todo to the backlog"
    (fun args ->
      match args with
      | [ description ] -> Todo.create description
      | _ -> raise (Sihl.Command.Exception "Usage: <todo description>"))
;;
