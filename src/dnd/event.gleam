import dnd/web.{type Msg}
import gleam/dynamic.{type DecodeError, type Dynamic}
import gleam/result
import lustre/event.{on}

type Decoded(a) =
  Result(a, List(DecodeError))

pub fn on_drag_start(msg: Msg) {
  use _ <- on("dragstart")
  Ok(msg)
}

pub fn on_drag_end(msg: Msg) {
  use _ <- on("dragend")
  Ok(msg)
}

pub fn on_drag_over(msg: Msg) {
  use e <- on("dragover")
  event.prevent_default(e)
  // io.debug(mouse_position_offset(e))
  Ok(msg)
}

pub fn on_drop(msg: Msg) {
  use _ <- on("drop")
  Ok(msg)
}

pub fn mouse_position_offset(event: Dynamic) -> Decoded(#(Float, Float)) {
  use x <- result.then(dynamic.field("offsetX", dynamic.float)(event))
  use y <- result.then(dynamic.field("offsetY", dynamic.float)(event))

  Ok(#(x, y))
}
// fn on_drag_enter(msg: Msg) {
//   use _ <- on("dragenter")
//   Ok(msg)
// }

// fn on_drag_leave(msg: Msg) {
//   use _ <- on("dragleave")
//   Ok(msg)
// }
