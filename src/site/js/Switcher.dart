#import('dart:html');

final osList = const ['mac', 'win', 'linux'];  // all supported OSs
var osName = 'linux'; // the currently displayed platform

/** Initializes osName and selects the corresponding radio button. */
void detectPlatform() {
  // osName is initially 'linux', since linux strings are unpredictable.
  if (window.navigator.appVersion.contains('Win')) {
    osName = 'win';
  } else if (window.navigator.appVersion.contains('Mac')) {
    osName = 'mac';
  }
  document.query('#$osName').attributes['checked'] = 'true';
}

/** Shows the text for the chosen platform (and no other). */
void filterPlatformText() {    
  // Get all the platform-specific elements.
  osList.forEach((os) {
    bool shouldShow = (os == osName);
    document.queryAll('.$os').forEach((el) {      
      el.hidden = !shouldShow; // Show or hide each element.
    });
  });
}

/** Allows the user to choose the OS. */
void registerHandlers() {
  osList.forEach((os) {
    document.query('#$os').on.click.add((e) {
      osName = os;
      filterPlatformText();
    });
  });
}

/** Ready, set, go! */
void main() {
  detectPlatform();
  filterPlatformText();
  registerHandlers();
}