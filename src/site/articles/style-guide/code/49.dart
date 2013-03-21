class ListBox {
  bool showScrollbars;

  ListBox({this.showScrollbars: false});
}

main() {
  // Good
  new ListBox(showScrollbars: true);

  // Bad
  new ListBox(showScrollbars:true);
  new ListBox(showScrollbars : true);
}