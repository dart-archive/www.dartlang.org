import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

@CustomTag('tute-slambook-form')
class TuteSlamBookForm extends PolymerElement {
  
  @observable String get firstName => __$firstName; String __$firstName = "mem"; set firstName(String value) { __$firstName = notifyPropertyChange(#firstName, __$firstName, value); }
  
  // Set up the maps for the form and give initial values.
  // Boolean values in this map are bound with bind-checked to checkboxes.
  @observable Map<String, bool> get favoriteThings => __$favoriteThings; Map<String, bool> __$favoriteThings = toObservable({
    'kittens': true, 'raindrops': false,
    'mittens': true, 'kettles': false}); set favoriteThings(Map<String, bool> value) { __$favoriteThings = notifyPropertyChange(#favoriteThings, __$favoriteThings, value); }
  
  // This map contains the rest of the forma data.
  @observable Map get theData => __$theData; Map __$theData = toObservable({
    'firstName':      'mem',
    'favoriteQuote':  'Enjoy all your meals.',
    'favoriteColor':  '#4169E1',
    'birthday':       '1963-08-30',
    'volume':         '11', //I want this to be bound to an integer!
    'catOrDog':       'dog',
    'music':          2,
    'zombies':        true
    // Add favoriteThings later...can't do it here...there is no this.
  }); set theData(Map value) { __$theData = notifyPropertyChange(#theData, __$theData, value); }

  @observable String get serverResponse => __$serverResponse; String __$serverResponse = ''; set serverResponse(String value) { __$serverResponse = notifyPropertyChange(#serverResponse, __$serverResponse, value); }
  HttpRequest request;

  void submitForm(Event e, var detail, Node target) {
    e.preventDefault(); // Don't do the default submit.
       
    request = new HttpRequest();
    
    request.onReadyStateChange.listen(onData); 
    
    // POST the data to the server.
    var url = 'http://127.0.0.1:4040';
    request.open('POST', url);
    request.send(_slambookAsJsonData());
  }
  
  void catOrDog(Event e, var detail, Element target) {
    theData['catOrDog'] = (target as RadioButtonInputElement).value;
  }
  
  void onData(_) {
    if (request.readyState == HttpRequest.DONE &&
        request.status == 200) {
      // Data saved OK.
      serverResponse = 'Server Sez: ' + request.responseText;
    } else if (request.readyState == HttpRequest.DONE &&
        request.status == 0) {
      // Status is 0...most likely the server isn't running.
      serverResponse = 'No server';
    }
  }
   
  void resetForm(Event e, var detail, Node target) {
    e.preventDefault(); // Default behavior clears elements,
                        // but bound values don't follow
                        // so have to do this explicitly.
    favoriteThings['kittens'] = false;
    favoriteThings['raindrops'] = false;
    favoriteThings['mittens'] = false;
    favoriteThings['kettles'] = false;
    
    theData['firstName'] = '';
    theData['favoriteQuote'] = '';
    theData['favoriteColor'] = '#FFFFFF';
    theData['birthday'] = '2013-01-01';
    theData['volume'] = '0';
    theData['catOrDog'] = 'cat';
    theData['music'] = 0;
    theData['zombies'] = false;
    serverResponse = 'Data reset.';
  }
  
  String _slambookAsJsonData() {
    // Put favoriteThings in the map.
    theData['favoriteThings'] = favoriteThings;
    return JSON.encode(theData);
  }
}
