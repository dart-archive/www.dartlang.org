// Some things we need.
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'count_down.dart';

@CustomTag('tute-count-down')
class CountDownComponent extends PolymerElement {
  
  // Observe errorMsg.
  // It displays a message for the user.
  @observable String get errorMsg => __$errorMsg; String __$errorMsg = ''; set errorMsg(String value) { __$errorMsg = notifyPropertyChange(#errorMsg, __$errorMsg, value); }

  // These are bound to input elements.
  @observable String get newMilestoneName => __$newMilestoneName; String __$newMilestoneName = "New Year's Day"; set newMilestoneName(String value) { __$newMilestoneName = notifyPropertyChange(#newMilestoneName, __$newMilestoneName, value); }
  @observable String get newMilestoneDate => __$newMilestoneDate; String __$newMilestoneDate = '2014-01-01'; set newMilestoneDate(String value) { __$newMilestoneDate = notifyPropertyChange(#newMilestoneDate, __$newMilestoneDate, value); }
  @observable String get newMilestoneTime => __$newMilestoneTime; String __$newMilestoneTime = '00:00:00'; set newMilestoneTime(String value) { __$newMilestoneTime = notifyPropertyChange(#newMilestoneTime, __$newMilestoneTime, value); }
  
  @observable MilestoneApp get appObj => __$appObj; MilestoneApp __$appObj = appObject; set appObj(MilestoneApp value) { __$appObj = notifyPropertyChange(#appObj, __$appObj, value); }
  
  /*
   * Click handlers.
   * NOTE: Minus - button handler is in xmilestone web component.
   */
  // Plus + button click handler.
  void addMilestone(Event e, var detail, Node target) {
    String str = newMilestoneDate + ' ' + newMilestoneTime;  
    DateTime occursOn = DateTime.parse(str);

    appObject.addMilestone(newMilestoneName, occursOn);
  }

  // Clear button click handler.
  void clear(Event e, var detail, Node target) {
    errorMsg = '';
    appObject.clear();
  }
   
  /*
   * Life-cycle bizness
   */
  void inserted() {
    appObject.start()
      .catchError((e) {
        ($['addbutton'] as ButtonElement).disabled = true;
        ($['clearbutton'] as ButtonElement).disabled = true;

        errorMsg = e.toString();
      });
  }
  
  void removed() {
    appObject.stop();
  }
} // end class
