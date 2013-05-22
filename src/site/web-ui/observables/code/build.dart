import 'package:web_ui/component_build.dart';
import 'dart:io';
import 'dart:async';

const dart2js = 'dart2js';

void main() {
  var args = new List.from(new Options().arguments);
  args.addAll(['--', '--no-rewrite-urls']);
  
  var toCompile = ['hello_world.html', 'observe_object.html',
                   'observe_list.html', 'observe_nested.html',
                   'manual_observe.html'];
  
  Future dwc = build(args, toCompile);
  
  dwc
    .then((_) => Process.run('cp', ['packages/browser/dart.js', 'out/']))
    .then((_) => Process.run('cp', ['App.css', 'out/']))
    .then((_) => Future.wait(toCompile
        .map((f) => '${f}_bootstrap.dart')
        .map((f) => Process.run(dart2js, ['out/$f', '--minify', '-oout/$f.js']))
      ))
    .then((_) => print('All done compiling with dart2js'))
    .catchError(print);
}