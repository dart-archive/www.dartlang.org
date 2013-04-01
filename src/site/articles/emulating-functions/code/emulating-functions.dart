typedef BinaryFunction(a,b);

class WannabeFunction {
  call(int a, int b) => a + b;
}

class NsmDummy {
  void foo() {
    print('foo');
  }
}

class NsmTester {

  NsmDummy bar() {
    return new NsmDummy();
  }

  void baz() {
    print('baz: not foo');
  }

  noSuchMethod(InvocationMirror msg) =>
    msg.memberName == 'foo' ? msg.invokeOn(bar())
                            : Function.apply(baz,
                                msg.positionalArguments,
                                msg.namedArguments);
}

void main() {
  var wf = new WannabeFunction();
  wf(3, 4); // 7

  assert(new WannabeFunction() is BinaryFunction);

  // We describe the signature of apply() in the article. These lines check to
  // make sure that that signature hasn't changed.
  var f = (String arg1, String arg2, {String arg3: '!'}) {};
  Function.apply(f, ['hello', 'world'], {'arg3': '!!'});

  NsmTester nsm = new NsmTester();
  nsm.foo();
  nsm.bleh();
}
