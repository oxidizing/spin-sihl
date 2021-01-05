type status =
  | Active
  | Done
  | Deleted

type t =
  { id : string
  ; description : string
  ; status : status
  ; created_at : Ptime.t
  ; updated_at : Ptime.t
  }

(* We use ppx to derive helper functions *)
(* [@@deriving fields, show, eq, make] *)

(* This creates a pizza model with a randomized id *)
let create description =
  { id = Uuidm.v `V4 |> Uuidm.to_string
  ; description
  ; status = Active
  ; created_at = Ptime_clock.now ()
  ; updated_at = Ptime_clock.now ()
  }
;;
