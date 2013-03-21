class Style {

}

class SuperView {
  SuperView(style) {

  }
}

class View extends SuperView {
  List _children;

  View(Style style, List children)
      : _children = children,
        super(style) {

    /* ... */
  }

}