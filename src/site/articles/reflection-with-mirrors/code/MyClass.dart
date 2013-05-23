import 'dart:mirrors';

class MyClass {
  int i, j;
  void my_method() {  }
  
  int sum() => i + j;

  MyClass(this.i, this.j);
  
  static noise() => 42;
  
  static var s;
}

main() {
  InstanceMirror myClassInstanceMirror = reflect(new MyClass(3, 4));
  ClassMirror MyClassMirror = myClassInstanceMirror.type; // Reflects MyClass
  
  InstanceMirror res = myClassInstanceMirror.invoke(const Symbol('sum'), []);
  // Returns an InstanceMirror on 7.
  print('sum = ${res.reflectee}');
    
  InstanceMirror v = MyClassMirror.invoke(const Symbol('noise'), []);
  // Returns an InstanceMirror on 42.
  print('noise = ${v.reflectee}');
  
  print('\nmethods:');
  Map<Symbol, MethodMirror> map = MyClassMirror.methods;
  map.values.forEach((MethodMirror mm) {print(MirrorSystem.getName(mm.simpleName));});
  
  print('\nmembers:');
  for (var k in MyClassMirror.members.keys) print(MirrorSystem.getName(k));
  MyClassMirror.setField(const Symbol('s'), 91);
  print(MyClass.s);
}

printAllMembersOf1(ClassMirror cm) {
  for (var m in cm.members.values) print(MirrorSystem.getName(m.simpleName));
}

printAllMembersOf2(ClassMirror cm) {
  for (var k in cm.members.keys) print(MirrorSystem.getName(k));
}
