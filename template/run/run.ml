(* This is the entry point to the Sihl app.

   The parts of your app come together here and are wired to the services.
   This is also the central registry for infrastructure services.
 *)

let commands = [ Command.Add_todo.run ]
let migrations = Database.Migration.all
let cleaners = [ Todo.cleaner ]
let jobs = []

let services =
  [ Sihl.Cleaner.Setup.register cleaners
    {%- if database == 'PostgreSql' %}
  ; Sihl.Migration.Setup.(register ~migrations postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Migration.Setup.(register ~migrations mariadb)
  {%- endif %}
  {%- if database == 'PostgreSql' %}
  ; Sihl.Token.Setup.(register postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Token.Setup.(register mariadb)
  {%- endif %}
  {%- if database == 'PostgreSql' %}
  ; Sihl.Email_template.Setup.(register postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Email_template.Setup.(register mariadb)
  {%- endif %}
  {%- if database == 'PostgreSql' %}
  ; Sihl.User.Setup.(register postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.User.Setup.(register mariadb)
  {%- endif %}
  {%- if database == 'PostgreSql' %}
  ; Sihl.Session.Setup.(register postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Session.Setup.(register mariadb)
  {%- endif %}
  {%- if database == 'PostgreSql' %}
  ; Sihl.Queue.Setup.(register ~jobs postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Queue.Setup.(register ~jobs mariadb)
  {%- endif %}
  ; Sihl.Email.Setup.(register smtp)
  ; Sihl.Schedule.Setup.register ()
  ; Sihl.Web.Setup.register Web.Route.all
  ]
;;


let () = Sihl.App.(empty |> with_services services |> run ~commands)
