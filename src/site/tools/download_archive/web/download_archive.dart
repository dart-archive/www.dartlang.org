import 'dart:async';
import 'dart:convert';
import 'dart:html';

const String storageApiBase = "https://www.googleapis.com/storage/v1/b/dart-archive/o";
const String storageBase = "https://storage.googleapis.com/dart-archive";
Map<String,TableElement> tables = { 'stable': querySelector("#stable"), 'dev': querySelector('#dev') };
Map<String,TableElement> apiTables = { 'stable': querySelector("#stable-api"), 'dev': querySelector('#dev-api') };
Map<String,SelectElement> versionSelectors = {
    'stable': querySelector('#stable-versions'),
    'dev': querySelector('#dev-versions')
};
Map<String,SelectElement> osSelectors = {
    'stable': querySelector('#stable-os'),
    'dev': querySelector('#dev-os')
};

void main() {
  HttpRequest.getString("$storageApiBase?prefix=channels/stable/release/&delimiter=/")
      .then((resp) { getListing('stable', resp); });
  HttpRequest.getString("$storageApiBase?prefix=channels/dev/release/&delimiter=/")
      .then((resp) { getListing('dev', resp); });
  
  versionSelectors['stable'].onChange.listen((Event event) { filterTable('stable', event); });
  versionSelectors['dev'].onChange.listen((Event event) { filterTable('dev', event); });
  osSelectors['stable'].onChange.listen((Event event) { filterTable('stable', event); });
  osSelectors['dev'].onChange.listen((Event event) { filterTable('dev', event); });
}

void filterTable(String channel, Event event) {
  String selectedVersion = versionSelectors[channel].selectedOptions[0].attributes['value'];
  String selectedOs = osSelectors[channel].selectedOptions[0].attributes['value'];
  if (selectedVersion == 'all' && selectedOs == 'all') {
    tables[channel].querySelectorAll('tr[data-version]').classes.remove('hidden');
  } else {
    String selector = 'tr';
    if (selectedVersion != 'all') { selector += '[data-version="$selectedVersion"]'; }
    if (selectedOs != 'all') { selector += '[data-os="$selectedOs"]'; }
    tables[channel].querySelectorAll('tr[data-version]').classes.add('hidden');
    tables[channel].querySelectorAll(selector).classes.remove('hidden');
  }

  if (selectedVersion == 'all') {
    apiTables[channel].querySelectorAll('tr[data-version]').classes.remove('hidden');
  } else {
    apiTables[channel].querySelectorAll('tr[data-version]').classes.add('hidden');
    apiTables[channel].querySelectorAll('tr[data-version="$selectedVersion"]').classes.remove('hidden');
  }
}

void getListing(String channel, String respString) {
  Map<String,Object> resp = JSON.decode(respString);
  List<String> versions = (resp["prefixes"] as List<String>);
  versions.removeWhere((e) => e.contains('latest'));

  // Format is lines of "channels/stable/release/\d+/".
  Iterable<Future> versionRequests = versions.map((String path) => HttpRequest.getString("$storageBase/${path}VERSION"));
  Future versionResponses = Future.wait(versionRequests.toList());
  versionResponses.then((Iterable versionStringsIter) {
    List<String> versionStrings = versionStringsIter.toList();
    List<Map<String,String>> y = versionStrings.map((e) => JSON.decode(e)).toList();
    y.sort((a,b) => - a['date'].compareTo(b['date']));
    y.forEach((v) { addVersion(channel, v); });
    versionSelectors[channel].options[1].selected = true;
    versionSelectors[channel].dispatchEvent(new Event("change"));
  });
}

const Map<String,String> archiveMap = const {
  'Mac': 'macos', 'Linux': 'linux', 'Windows': 'windows',
  '32-bit': 'ia32', '64-bit': 'x64',
  'Dart SDK': 'dartsdk', 'Dartium': 'dartium', 'Dart Editor': 'darteditor',
};

const Map<String,String> directoryMap = const {
  'Dart SDK': 'sdk', 'Dartium': 'dartium', 'Dart Editor': 'editor',
};

const Map<String,String> suffixMap = const {
  'Dart SDK': '-release.zip',
  'Dartium': '-release.zip',
  'Dart Editor': '.zip'
};

const Map<String,Object> platforms = const {
  'Mac': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK',            'Dart Editor'] },
  'Linux': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'] },
  'Windows': const {
    '32-bit': const ['Dart SDK', 'Dartium', 'Dart Editor'],
    '64-bit': const ['Dart SDK',            'Dart Editor'] },
};

void addVersion(String channel, Map<String,String> version) {
  OptionElement o = new OptionElement()
      ..text = version['version']
      ..attributes['value'] = version['version'];
  versionSelectors[channel].children.add(o);

  // Json is like: { 'revision': '...', 'version': '...', 'date': '...' }.
  platforms.forEach((String name, Map<String,List> widthListings) {
    widthListings.forEach((String width, List<String> archives) {
      TableRowElement row = tables[channel].addRow()
          ..attributes['data-version'] = version['version']
          ..attributes['data-os'] = archiveMap[name];
      SpanElement rev = new SpanElement()
          ..text = '  (rev ${version['revision']})'
          ..classes.add('muted');
      row.addCell()..text = version['version']
          ..append(rev);
      row.addCell()..text = name;
      row.addCell()..classes.add('nowrap')..text = width;
      List<String> possibleArchives = ['Dart SDK', 'Dartium', 'Dart Editor'];
      TableCellElement c = row.addCell()
          ..classes.add('archives');
      possibleArchives.forEach((String pa) {
        if (archives.contains(pa)) {
          String uri = '$storageBase/channels/$channel/release/${version['revision']}/' +
              '${directoryMap[pa]}/${archiveMap[pa]}-${archiveMap[name]}-${archiveMap[width]}${suffixMap[pa]}';
          c.append(new AnchorElement()
              ..text = pa
              ..attributes['href']= uri);
          if (pa != 'Dart Editor' && int.parse(version['revision']) > 38976) {
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

  TableRowElement row = apiTables[channel].addRow()
      ..attributes['data-version'] = version['version'];
  SpanElement rev = new SpanElement()
      ..text = '  (rev ${version['revision']})'
      ..classes.add('muted');
  row.addCell()..text = version['version']
      ..append(rev);
  TableCellElement c = row.addCell()
      ..classes.add('archives');
  String uri = '$storageBase/channels/$channel/release/${version['revision']}/' +
      'api-docs/dart-api-docs.zip';
  c.append(new AnchorElement()
      ..text = 'JSON-formatted API Documentation'
      ..attributes['href']= uri);

  List<Element> templateRows = tables[channel].querySelectorAll('.template');
  if (templateRows != null) { templateRows.forEach((row) { row.remove(); }); }
  templateRows = apiTables[channel].querySelectorAll('.template');
  if (templateRows != null) { templateRows.forEach((row) { row.remove(); }); }
}