import dnd/event.{on_drag_end, on_drag_over, on_drag_start, on_drop}
import dnd/web.{
  type Card, type Column, type Msg, Card, Column, OnDragEnd, OnDragNoTarget,
  OnDragOver, OnDragStart, OnDrop, move_card,
}

import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}

import lustre
import lustre/attribute.{attribute, class, id}
import lustre/element.{text}
import lustre/element/html.{div, p}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

type Model {
  Model(
    columns: List(Column),
    target_card: Option(Card),
    column_to: Option(Column),
    column_from: Option(Column),
  )
}

fn init(_flags) {
  Model(
    [
      Column(0, "A", [Card(2, "A1"), Card(3, "A2")]),
      Column(1, "B", [Card(4, "B1"), Card(5, "B2")]),
    ],
    None,
    None,
    None,
  )
}

fn update(model: Model, msg: Msg) {
  io.debug(msg)
  // io.debug(model)

  case msg {
    OnDragStart(card, column_from) ->
      Model(..model, target_card: Some(card), column_from: Some(column_from))
    OnDragEnd ->
      Model(..model, target_card: None, column_from: None, column_to: None)
    OnDragOver(column) -> Model(..model, column_to: Some(column))
    OnDragNoTarget -> Model(..model, column_to: None)
    OnDrop -> {
      let assert Some(card) = model.target_card
      let assert Some(column_from) = model.column_from
      let assert Some(column_to) = model.column_to

      Model(
        ..model,
        columns: move_card(model.columns, column_from, column_to, card),
      )
    }
  }
}

fn view(model: Model) {
  let Model(columns, ..) = model

  board(columns)
}

fn board(columns: List(Column)) {
  div([class("flex gap-10 p-20")], list.map(columns, fn(el) { column(el) }))
}

fn column(column: Column) {
  let children = [p([class("text-center font-bold")], [text(column.title)])]

  div(
    [
      class("flex flex-col bg-pink-100 p-10 gap-3"),
      on_drag_over(OnDragOver(column)),
      id("drop-target"),
      on_drop(OnDrop),
    ],
    list.append(children, list.map(column.cards, fn(el) { card(el, column) })),
  )
}

fn card(card: Card, column: Column) {
  div(
    [
      class("bg-pink-300 p-10"),
      on_drag_start(OnDragStart(card, column)),
      on_drag_end(OnDragEnd),
      attribute("draggable", "true"),
    ],
    [p([], [text(card.title)])],
  )
}
