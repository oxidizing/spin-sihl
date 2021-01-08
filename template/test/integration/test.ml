let services =
  [ Sihl.Cleaner.Setup.register [ Todo.cleaner ]
  {%- if database == 'PostgreSql' %}
  ; Sihl.Migration.Setup.(register ~migrations:Database.Migration.all postgresql)
  {%- endif %}
  {%- if database == 'MariaDb' %}
  ; Sihl.Migration.Setup.(register ~migrations:Database.Migration.all mariadb)
  {%- endif %}
  ; Sihl.Web.Setup.register Web.Route.all
  ]
;;

let () =
  let open Lwt.Syntax in
  Unix.putenv "SIHL_ENV" "test";
  {%- if database == 'PostgreSql' %}
  Unix.putenv "DATABASE_URL" "postgres://admin:password@127.0.0.1:5432/dev";
  {%- endif %}
  {%- if database == 'MariaDb' %}
  Unix.putenv "DATABASE_URL" "mariadb://admin:password@127.0.0.1:3306/dev";
  {%- endif %}
  Logs.set_level (Sihl_core.Log.get_log_level ());
  Logs.set_reporter (Sihl_core.Log.cli_reporter ());
  Lwt_main.run
    (let* _ = Sihl_core.Container.start_services services in
     let* () = Sihl_facade.Migration.run_all () in
     Alcotest_lwt.run "integration" Cases.suite)
;;
