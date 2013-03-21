class Task {

  Task.oneShot() {

  }

  Task.repeating() {

  }
}

class ListBox {
  ListBox({bool scroll, bool showScrollbars}) {
    
  }
}

main() {
  new Task.oneShot();
  new Task.repeating();
  new ListBox(scroll: true, showScrollbars: true);
}