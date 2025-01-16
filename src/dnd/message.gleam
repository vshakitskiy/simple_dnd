import dnd/web.{type Card, type Column}

pub type Msg {
  OnDragStart(card: Card, curr_column_id: Int)
  OnDragEnd
  OnDragOver(column: Column)
  OnDragNoTarget
  OnDrop
}
