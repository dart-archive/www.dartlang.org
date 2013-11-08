import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

@CustomTag('tute-its-all-about-you')
class TuteItsAllAboutYou extends PolymerElement {
  // JSON strings, bound to HTML
  @observable String get intAsJson => __$intAsJson; String __$intAsJson; set intAsJson(String value) { __$intAsJson = notifyPropertyChange(#intAsJson, __$intAsJson, value); }
  @observable String get doubleAsJson => __$doubleAsJson; String __$doubleAsJson; set doubleAsJson(String value) { __$doubleAsJson = notifyPropertyChange(#doubleAsJson, __$doubleAsJson, value); }
  @observable String get stringAsJson => __$stringAsJson; String __$stringAsJson; set stringAsJson(String value) { __$stringAsJson = notifyPropertyChange(#stringAsJson, __$stringAsJson, value); }
  @observable String get listAsJson => __$listAsJson; String __$listAsJson; set listAsJson(String value) { __$listAsJson = notifyPropertyChange(#listAsJson, __$listAsJson, value); }
  @observable String get boolAsJson => __$boolAsJson; String __$boolAsJson; set boolAsJson(String value) { __$boolAsJson = notifyPropertyChange(#boolAsJson, __$boolAsJson, value); }
  @observable String get mapAsJson => __$mapAsJson; String __$mapAsJson; set mapAsJson(String value) { __$mapAsJson = notifyPropertyChange(#mapAsJson, __$mapAsJson, value); }
  
  // Data input as strings, bound to input fields
  @observable String get favoriteNumber => __$favoriteNumber; String __$favoriteNumber=''; set favoriteNumber(String value) { __$favoriteNumber = notifyPropertyChange(#favoriteNumber, __$favoriteNumber, value); }
  @observable String get valueOfPi => __$valueOfPi; String __$valueOfPi=''; set valueOfPi(String value) { __$valueOfPi = notifyPropertyChange(#valueOfPi, __$valueOfPi, value); }
  @observable String get horrorScope => __$horrorScope; String __$horrorScope=''; set horrorScope(String value) { __$horrorScope = notifyPropertyChange(#horrorScope, __$horrorScope, value); }
  @observable String get favOne => __$favOne; String __$favOne=''; set favOne(String value) { __$favOne = notifyPropertyChange(#favOne, __$favOne, value); }
  @observable String get favTwo => __$favTwo; String __$favTwo=''; set favTwo(String value) { __$favTwo = notifyPropertyChange(#favTwo, __$favTwo, value); }
  @observable String get favThree => __$favThree; String __$favThree=''; set favThree(String value) { __$favThree = notifyPropertyChange(#favThree, __$favThree, value); }
  @observable String get chocolate => __$chocolate; String __$chocolate=''; set chocolate(String value) { __$chocolate = notifyPropertyChange(#chocolate, __$chocolate, value); }
  
  void showJson(Event e, var detail, Node target) {
    // Typed data to convert to JSON
    num favNum = int.parse(favoriteNumber);
    num pi = double.parse(valueOfPi);
    var anElement = $['lovechocolate'];
    bool choco = (anElement as RadioButtonInputElement).checked;
    
    List<String> favoriteThings = [ favOne, favTwo, favThree ];
  
    Map formData = {
      'favoriteNumber': favNum,
      'valueOfPi': pi,
      'chocolate': choco,
      'horrorScope': horrorScope,
      'favoriteThings': favoriteThings
    };
  
    // Convert everything to JSON
    intAsJson = JSON.encode(favNum);          // int
    doubleAsJson = JSON.encode(pi);           // double
    boolAsJson = JSON.encode(choco);          // boolean
    stringAsJson = JSON.encode(horrorScope);  // string
    listAsJson = JSON.encode(favoriteThings); // list of strings
    mapAsJson = JSON.encode(formData);        // map with string keys
                                                 // and mixed values
  }
  
  void inserted() {
    super.inserted();
    _populateFromJson();
    showJson(null, null, null);
  }
  
  void _populateFromJson() {
  
  String jsonDataAsString = '''
  { "favoriteNumber":44,
    "valueOfPi":3.141592,
    "chocolate":true,
    "horrorScope":"virgo",
    "favoriteThings":["raindrops",
                      "whiskers",
                      "mittens"]
  }
  ''';
  
    Map jsonData = JSON.decode(jsonDataAsString);
    
    favoriteNumber = jsonData['favoriteNumber'].toString();
    valueOfPi = jsonData['valueOfPi'].toString();
    horrorScope = jsonData['horrorScope'];
    favOne = jsonData['favoriteThings'][0];
    favTwo = jsonData['favoriteThings'][1];
    favThree = jsonData['favoriteThings'][2];
  
    if (jsonData['chocolate']) {
      var anElement = $['lovechocolate'];
      (anElement as RadioButtonInputElement).checked = true;
    } else {
      var anElement = $['noloveforchocolate'];
      (anElement as RadioButtonInputElement).checked = true;
    }
    
  }
}