port module TodoApp exposing (..)

import Browser
import Html exposing (Attribute, Html, button, div, input, li, map, text, ul)
import Html.Attributes exposing (name, placeholder, style, value)
import Html.Events exposing (onClick, onInput)
import Json.Decode exposing (Decoder, int, string)
import List exposing (..)
import Maybe exposing (..)
import Task exposing (perform, succeed)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias TodoModel =
    { inputValue : String, todos : List ToDoList }


type alias ToDoList =
    { index : Int, value : String }


type Msg
    = InputValue String
    | ClearInput
    | AddTodo
    | ClearTodo Int


init : TodoModel -> ( TodoModel, Cmd Msg )
init flags =
    ( { todos = [], inputValue = "" }, Cmd.none )


subscriptions : TodoModel -> Sub Msg
subscriptions model =
    Sub.none


viewTodoList : List ToDoList -> Html Msg
viewTodoList todolist =
    div []
        (List.map
            (\item ->
                div [ style "display" "flex", style "justify-content" "space-between", style "border" "1px solid black", style "width" "200px" ]
                    [ text "Value:"
                    , text item.value
                    , div [ style "color" "red", style "cursor" "pointer", onClick (ClearTodo item.index) ]
                        [ text " X "
                        ]
                    ]
            )
            todolist
        )


view : TodoModel -> Html Msg
view model =
    div []
        [ input [ name "input1", placeholder "Input something", onInput InputValue ] []
        , button [ onClick AddTodo ] [ text "Save" ]
        , div [] [ viewTodoList model.todos ]
        ]


clearInputValue : msg -> Cmd msg
clearInputValue m =
    Task.perform (always m) (Task.succeed ())


clearTodoByIndex : ( Int, List ToDoList ) -> List ToDoList
clearTodoByIndex ( index, todoList ) =
    let
        clearByIndex =
            --
            let
                notMatch item =
                    index /= item.index
            in
            List.filter notMatch todoList
    in
    clearByIndex


update : Msg -> TodoModel -> ( TodoModel, Cmd Msg )
update message model =
    case message of
        InputValue value ->
            ( { model | inputValue = value }, Cmd.none )

        ClearInput ->
            ( { model | inputValue = "" }, Cmd.none )

        AddTodo ->
            let
                appendItemIntoList =
                    List.append model.todos [ { index = List.length model.todos, value = model.inputValue } ]
            in
            ( { model | todos = appendItemIntoList }, clearInputValue ClearInput )

        ClearTodo index ->
            ( { model | todos = clearTodoByIndex ( index, model.todos ) }, Cmd.none )
