import 'dart:html';

InputElement toDoInput;
UListElement toDoList;

void main() {
  toDoInput = query('#to-do-input');
  toDoList = query('#to-do-list');
  toDoInput.onChange.listen(addToDoItem);
}

void addToDoItem(Event e) {
  var newToDo = new LIElement();
  newToDo.text = toDoInput.value;
  toDoInput.value = '';
  toDoList.children.add(newToDo);
}
