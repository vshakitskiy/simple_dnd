import gleam/list

pub type Column {
  Column(id: Int, title: String, cards: List(Card))
}

pub type Card {
  Card(id: Int, title: String)
}

pub type Msg {
  OnDragStart(card: Card, column_from: Column)
  OnDragEnd
  OnDragOver(column_to: Column)
  OnDragNoTarget
  OnDrop
}

pub fn delete_card(column: Column, card: Card) -> Column {
  Column(
    ..column,
    cards: list.filter(column.cards, fn(el) { el.id != card.id }),
  )
}

pub fn append_card(column: Column, card: Card) -> Column {
  Column(..column, cards: list.append(column.cards, [card]))
}

pub fn move_card(
  columns: List(Column),
  column_from: Column,
  column_to: Column,
  card: Card,
) -> List(Column) {
  list.map(columns, fn(el) {
    case el.id {
      _ if el.id == column_from.id -> delete_card(el, card)
      _ if el.id == column_to.id -> append_card(el, card)
      _ -> el
    }
  })
}
