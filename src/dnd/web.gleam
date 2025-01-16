import gleam/list

pub type Pair(a) =
  #(Int, a)

pub fn get_id(pair: Pair(a)) -> Int {
  pair.0
}

pub fn get_content(pair: Pair(a)) -> a {
  pair.1
}

pub type Column {
  Column(id: Int, title: String, cards: List(Card))
}

pub type Card {
  Card(id: Int, title: String)
}
// pub fn delete_card(column: Pair(Column), card: Pair(Card)) -> Pair(Column) {
//   let content = column |> get_content()
//   #(
//     column |> get_id(),
//     Column(
//       ..content,
//       cards: list.filter(content.cards, fn(pair_card) {
//         pair_card |> get_id() != get_id(card)
//       }),
//     ),
//   )
// }

// pub fn append_card(column: Pair(Column), card: Pair(Card)) -> Pair(Column) {
//   let content = column |> get_content()
//   #(
//     column |> get_id(),
//     Column(..content, cards: list.append(content.cards, [card])),
//   )
// }

// pub fn move_card(
//   columns: List(Pair(Column)),
//   from: Int,
//   to: Int,
//   card: Pair(Card),
// ) -> List(Pair(Column)) {
//   let assert Ok(from_column) =
//     list.find(columns, fn(pair_column) { pair_column |> get_id() == from })
//   let assert Ok(to_column) =
//     list.find(columns, fn(pair_column) { pair_column |> get_id() == to })

//   list.map(columns, fn(pair_column) {
//     let id = pair_column |> get_id()
//     case id {
//       _ if id == from -> from_column |> delete_card(card)
//       _ if id == to -> to_column |> append_card(card)
//       _ -> pair_column
//     }
//   })
// }
