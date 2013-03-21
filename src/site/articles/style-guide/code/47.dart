test1() {
  getEmptyFn(a) {
    return () {};
  }
}

// Bad
test2() {
  getEmptyFn(a){
    return (){};
  }
}