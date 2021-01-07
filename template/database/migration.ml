(* Database migrations. *)

{%- if database == 'PostgreSql' %}
let create_todos_table =
  Sihl.Migration.create_step
    ~label:"create todos table"
    {sql|
     CREATE TABLE IF NOT EXISTS todos (
       id serial,
       uuid uuid NOT NULL,
       description VARCHAR(128) NOT NULL,
       status VARCHAR(32) NOT NULL,
       created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
       PRIMARY KEY (id),
       UNIQUE (uuid)
     );
     |sql}
;;

let all = [
    Sihl.Migration.(empty "{{ project_slug }}" |> add_step create_todos_table) ]
{%- endif %}
{%- if database == 'MariaDb' %}
let create_todos_table =
  Sihl.Migration.create_step
    ~label:"create todos table"
    {sql|
     CREATE TABLE IF NOT EXISTS todos (
       id BIGINT UNSIGNED AUTO_INCREMENT,
       uuid BINARY(16) NOT NULL,
       description VARCHAR(128) NOT NULL,
       status VARCHAR(32) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
       PRIMARY KEY (id),
       CONSTRAINT unique_uuid UNIQUE KEY (uuid)
     ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
     |sql}
;;

let all = [
    Sihl.Migration.(empty "{{ project_slug }}" |> add_step create_todos_table) ]
{%- endif %}
