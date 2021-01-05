let cleaners = [ Todo.cleaner ]

  (* TODO [jerben] add all services per default:
    Service.Token.register ();
    Service.User.register ();
    Service.BlockingEmail.register ();
    Service.Email.register ();
    Service.EmailTemplate.register ();
    Service.Session.register ();
    Service.Migration.register ~migrations ();
    Service.Schedule.register ~schedules ();
    Service.Queue.register ~jobs (); *)

let services =
  [ Sihl.Cleaner.Setup.register cleaners
  {%- if database == 'PostgreSql' %}
  ; Sihl.Migration.Setup.(register ~migrations:Database.Migration.all postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Migration.Setup.(register ~migrations:Database.Migration.all mariadb)
  {%- endif %}
  ; Sihl.Web.Setup.register Web.Route.all
  ]
;;

let commands = [ Command.Add_todo.run ]
let () = Sihl.App.(empty |> with_services services |> run ~commands)
