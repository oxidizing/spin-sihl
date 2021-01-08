open Lwt.Syntax

let create_list_and_do _ () =
  let open Todo.Model in
  let* () = Sihl_core.Cleaner.clean_all () in
  let* _ = Todo.create "do laundry" in
  let* _ = Todo.create "hoover" in
  let* todos = Todo.search 10 in
  let t1, t2 =
    match todos with
    | [ t1; t2 ], n ->
      Alcotest.(check int "has 2" 2 n);
      t1, t2
    | _ -> Alcotest.fail "Unexpected number of todos received"
  in
  Alcotest.(check string "has description" "hoover" t1.description);
  Alcotest.(check string "has description" "do laundry" t2.description);
  let* () = Todo.do_ t1 in
  let* t1 = Todo.find t1.id in
  Alcotest.(check bool "is done" true (Todo.is_done t1));
  Lwt.return ()
;;

let list_todos_json_api _ () =
  let open Yojson.Basic.Util in
  let* () = Sihl_core.Cleaner.clean_all () in
  let* _ = Todo.create "do laundry" in
  let* _, body = Cohttp_lwt_unix.Client.get (Uri.of_string "http://localhost:3000/api") in
  let* json = Cohttp_lwt.Body.to_string body in
  let todos = json |> Yojson.Basic.from_string |> to_list in
  let description =
    Caml.List.map (fun todo -> todo |> member "description" |> to_string) todos |> List.hd
  in
  Alcotest.(check string "returns same title" "do laundry" description);
  Lwt.return ()
;;

let suite =
  Alcotest_lwt.
    [ "service", [ test_case "create, list and do" `Quick create_list_and_do ]
    ; "http", [ test_case "list from json api" `Quick list_todos_json_api ]
    ]
;;
