import 'dart:html';

InputElement toDoInput;
UListElement toDoList;

void main() {
  toDoInput = query('#to-do-input');
  toDoList = query('#to-do-list');
  toDoInput.on.change.add((e) => addToDoItem());
}

void addToDoItem() {
  var newToDo = new LIElement();
  newToDo.text = toDoInput.value;
  toDoInput.value = "";
  toDoList.elements.add(newToDo);
}