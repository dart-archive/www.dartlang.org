#!/usr/bin/env dart

import 'dart:io';
import 'dart:async';

Directory outputDir;

String frontMatter(title) {
  final yaml = """
---
layout: book
title: "${title} from Dart: Up and Running"
description: "Read ${title} of Dart: Up and Running, published by O'Reilly."
---
""";
  return yaml;
}

convertFile(String fileName) {
  print(fileName);
  var file = new File(fileName);
  var contents = file.readAsStringSync();
  var title = new RegExp(r'<title>(.*)</title>').firstMatch(contents)[1];
  var start = contents.indexOf(r'<div class="navheader">');
  var end = contents.lastIndexOf(r'</body></html>');
  var body = contents.substring(start, end);
  var filenameOnly = new Path(fileName).filename;

  writeFile(filenameOnly, title, body);
}

writeFile(String fileName, String title, String body) {
  var out = new File('${outputDir.path}/${fileName}');
  out.writeAsStringSync(frontMatter(title));
  out.writeAsStringSync(body, mode: FileMode.APPEND, encoding: Encoding.UTF_8);
}

checkDir(Directory dir) {
  if (!dir.existsSync()) {
    print("Directory '${dir.path}' does not exist");
    exit(1);
  }
}

Future<List<String>> dirContents(Directory dir) {
  var filenames = <String>[];
  var completer = new Completer();
  var lister = dir.list();
  lister.onFile = (filename) => filenames.add(filename);
  lister.onDone = (_) => completer.complete(filenames);
  return completer.future;
}

main() {
  var args = new Options().arguments;
  if (args.length != 2) {
    print("Usage: convert_book.dart dir_of_html output_dir");
    exit(1);
  }

  var inputDir = new Directory(args[0]);
  outputDir = new Directory(args[1]);
  checkDir(inputDir);
  checkDir(outputDir);

  dirContents(inputDir)
    .then((filenames) => filenames.where((f) => f.endsWith(".html")))
    .then((htmlFilenames) => htmlFilenames.forEach((f) => convertFile(f)));
}