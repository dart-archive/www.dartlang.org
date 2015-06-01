import 'dart:async';
import 'dart:convert';
import 'dart:html';

const String storageApiBase =
    "https://www.googleapis.com/storage/v1/b/dart-archive/o";
const String storageBase = "https://storage.googleapis.com/dart-archive";
Map<String, TableElement> tables = {
  'stable': querySelector("#stable"),
  'dev': querySelector('#dev')
};
Map<String, SelectElement> versionSelectors = {
  'stable': querySelector('#stable-versions'),
  'dev': querySelector('#dev-versions')
};
Map<String, SelectElement> osSelectors = {
  'stable': querySelector('#stable-os'),
  'dev': querySelector('#dev-os')
};

void main() {
  HttpRequest
      .getString("$storageApiBase?prefix=channels/stable/release/&delimiter=/")
      .then((resp) {
    getListing('stable', resp);
  });
  HttpRequest
      .getString("$storageApiBase?prefix=channels/dev/release/&delimiter=/")
      .then((resp) {
    getListing('dev', resp);
  });

  versionSelectors['stable'].onChange.listen((Event event) {
    filterTable('stable', event);
  });
  versionSelectors['dev'].onChange.listen((Event event) {
    filterTable('dev', event);
  });
  osSelectors['stable'].onChange.listen((Event event) {
    filterTable('stable', event);
  });
  osSelectors['dev'].onChange.listen((Event event) {
    filterTable('dev', event);
  });
}

void filterTable(String channel, Event event) {
  String selectedVersion =
      versionSelectors[channel].selectedOptions[0].attributes['value'];
  String selectedOs =
      osSelectors[channel].selectedOptions[0].attributes['value'];
  if (selectedVersion == 'all' && selectedOs == 'all') {
    tables[channel].querySelectorAll('tr[data-version]').classes
        .remove('hidden');
  } else {
    tables[channel].querySelectorAll('tr[data-version]').classes.add('hidden');
    String selector = 'tr';
    if (selectedVersion != 'all') {
      selector += '[data-version="$selectedVersion"]';
    }
    tables[channel].querySelectorAll(selector + '[data-os="api"]').classes
        .remove('hidden');
    if (selectedOs != 'all') {
      selector += '[data-os="$selectedOs"]';
    }
    tables[channel].querySelectorAll(selector).classes.remove('hidden');
  }
}

DateTime parseDateTime(String date) {
  try {
    return DateTime.parse(date);
  } catch (_) {}

  if (date.length == 12) {
    // Old dates show up like '201504230115', put them in a format that
    // DateTime.parse understands.
    return DateTime.parse('${date.substring(0, 4)}-${date.substring(4, 6)}-'
        '${date.substring(6, 8)} ${date.substring(8, 10)}:'
        '${date.substring(10, 12)}');
  }

  throw 'unrecognized DateTime format: $date';
}

void getListing(String channel, String respString) {
  Map<String, Object> resp = JSON.decode(respString);
  List<String> versions = (resp["prefixes"] as List<String>);
  versions.removeWhere((e) => e.contains('latest'));

  // Format is lines of "channels/stable/release/\d+/".
  Iterable<Future> versionRequests = versions.map(
      (String path) => HttpRequest.getString("$storageBase/${path}VERSION"));
  Future versionResponses = Future.wait(versionRequests.toList());
  versionResponses.then((Iterable versionStringsIter) {
    List<String> versionStrings = versionStringsIter.toList();
    List<Map<String, String>> y =
        versionStrings.map((e) => JSON.decode(e)).toList();
    y.sort((a, b) =>
        -(parseDateTime(a['date']).compareTo(parseDateTime(b['date']))));
    y.forEach((v) {
      addVersion(channel, v);
    });
    versionSelectors[channel].options[1].selected = true;
    versionSelectors[channel].dispatchEvent(new Event("change"));
  });
}

const Map<String, String> archiveMap = const {
  'Mac': 'macos',
  'Linux': 'linux',
  'Windows': 'windows',
  '32-bit': 'ia32',
  '64-bit': 'x64',
  'Dart SDK': 'dartsdk',
  'Dartium': 'dartium',
  'Dart Editor': 'darteditor',
};

const Map<String, String> directoryMap = const {
  'Dart SDK': 'sdk',
  'Dartium': 'dartium',
  'Dart Editor': 'editor',
};

const Map<String, String> suffixMap = const {
  'Dart SDK': '-release.zip',
  'Dartium': '-release.zip',
  'Dart Editor': '.zip'
};

const Map<String, Object> platforms = const {
  'Mac': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK', 'Dart Editor']
  },
  'Linux': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK', 'Dartium', 'Dart Editor']
  },
  'Windows': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK', 'Dart Editor']
  },
};

void addVersion(String channel, Map<String, String> version) {
  OptionElement o = new OptionElement()
    ..text = version['version']
    ..attributes['value'] = version['version'];
  versionSelectors[channel].children.add(o);

  // Json is like: { 'revision': '...', 'version': '...', 'date': '...' }.
  platforms.forEach((String name, Map<String, List> widthListings) {
    widthListings.forEach((String width, List<String> archives) {
      TableRowElement row = tables[channel].addRow()
        ..attributes['data-version'] = version['version']
        ..attributes['data-os'] = archiveMap[name];

      var versionCell = row.addCell()..text = version['version'];
      if (version.containsKey('revision')) {
        versionCell.append(new SpanElement()
          ..text = '  (rev ${version['revision']})'
          ..classes.add('muted'));
      }

      row.addCell()..text = name;
      row.addCell()
        ..classes.add('nowrap')
        ..text = width;
      List<String> possibleArchives = ['Dart SDK', 'Dartium', 'Dart Editor'];
      TableCellElement c = row.addCell()..classes.add('archives');
      possibleArchives.forEach((String pa) {
        if (archives.contains(pa)) {
          // Attempt to parse the revision number, this only works for
          // pre-github revisions.
          int parsedRevision;
          try {
            parsedRevision = int.parse(version['revision']);
          } catch (e) {}

          /// Use the revision number for anything <= 1.11.0-dev.0.0 (rev 45519)
          /// and the version string for later ones.
          String versionString;
          if (version.containsKey('revision') &&
              parsedRevision != null &&
              parsedRevision <= 45519) {
            versionString = version['revision'];
          } else {
            versionString = version['version'];
          }
          String uri = '$storageBase/channels/$channel/release/$versionString' +
              '/${directoryMap[pa]}/${archiveMap[pa]}-${archiveMap[name]}-'
              '${archiveMap[width]}${suffixMap[pa]}';
          c.append(new AnchorElement()
            ..text = pa
            ..attributes['href'] = uri);
          if (pa != 'Dart Editor' &&
              (parsedRevision == null || parsedRevision > 38976)) {
            c.append(new AnchorElement()
              ..text = "(SHA-256)"
              ..attributes['href'] = '$uri.sha256sum'
              ..classes.add('sha'));
          }
          c.append(new Element.br());
        }
      });
    });
  });

  TableRowElement row = tables[channel].addRow()
    ..attributes['data-version'] = version['version']
    ..attributes['data-os'] = 'api';
  SpanElement rev = new SpanElement()
    ..text = '  (rev ${version['revision']})'
    ..classes.add('muted');
  row.addCell()
    ..text = version['version']
    ..append(rev);
  row.addCell()..text = '---';
  row.addCell()..text = '---';
  TableCellElement c = row.addCell()..classes.add('archives');
  String uri =
      '$storageBase/channels/$channel/release/${version['revision']}/' +
          'api-docs/dart-api-docs.zip';
  c.append(new AnchorElement()
    ..text = 'JSON-formatted API documentation'
    ..attributes['href'] = uri);

  List<Element> templateRows = tables[channel].querySelectorAll('.template');
  if (templateRows != null) {
    templateRows.forEach((row) {
      row.remove();
    });
  }
}
