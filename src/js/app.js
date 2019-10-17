import { Elm } from "../components/todo.elm";
Elm.TodoApp.init({
    node: document.getElementById("app"),
    flags: { inputValue: "", todos: [] }
});
