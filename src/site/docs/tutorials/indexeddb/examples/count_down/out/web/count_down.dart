import 'dart:async';
import 'dart:indexed_db';
import 'milestone.dart';
import 'package:polymer/polymer.dart';

/*
 * The VIEW-MODEL for the app.
 * 
 * Implements the business logic 
 * and manages the information exchanges
 * between the MODEL (Milestone & MilestoneStore)
 * and the VIEW (CountDownComponent & MilestoneComponent).
 * 
 * Manages a Timer to update the milestones.
 */

MilestoneApp appObject = new MilestoneApp();


class MilestoneApp extends ChangeNotifierBase {
  /****
   * Some things we need...
   */
  // When there are no active milestones, timer is null.
  Timer timer = null;
  
  // Is IndexedDB supported in this browser?
  bool idbAvailable = IdbFactory.supported;
  
  // A place to save the milestones (is the MODEL).
  MilestoneStore _store = new MilestoneStore();
  
  // Called from the VIEW.
  @observable bool get hazMilestones => __$hazMilestones; bool __$hazMilestones; set hazMilestones(bool value) { __$hazMilestones = notifyPropertyChange(#hazMilestones, __$hazMilestones, value); }
  
  // The list of milestones in the MODEL.
  List<Milestone> get milestones => _store.milestones;
 
  /****
   * Life-cycle methods...
   */
  
  // Called from the VIEW when the element is inserted into the DOM.
  Future start() {
    if (!idbAvailable) {
      return new Future.error('IndexedDB not supported.');
    }
    
    return _store.open().then((_) {
      _startMilestoneTimer();
      hazMilestones = notifyPropertyChange(const Symbol('hazMilestones'),
          hazMilestones, (milestones.length == 0) ? false : true);

    });
  }
  
  // Called from the VIEW when the element is removed from the DOM.
  void stop() {
    _stopMilestoneTimer(true);
  }

  /****
   * Click handlers...
   * Called from the VIEW (xcountdown) when the user clicks a button.
   * Delegates to MODEL.
   */
  
  void addMilestone(String milestoneName, DateTime occursOn) {
    // Make sure milestone is in the future, and not in the past.
    if (occursOn.isAfter(new DateTime.now())) {
      _store.add(milestoneName, occursOn).then((_) {
        _startMilestoneTimer();
        hazMilestones = notifyPropertyChange(const Symbol('hazMilestones'),
            hazMilestones, (milestones.length == 0) ? false : true);
      },
      onError: (e) { print('duplicate key'); } );
    }
  }

  Future removeMilestone(Milestone milestone) {
    return _store.remove(milestone).then((_) {
      _stopMilestoneTimer(false);
      hazMilestones = notifyPropertyChange(const Symbol('hazMilestones'),
          hazMilestones, (milestones.length == 0) ? false : true);
   });
  }
  
  Future clear() {
    return _store.clear().then((_) {
      _stopMilestoneTimer(false);
      hazMilestones = notifyPropertyChange(const Symbol('hazMilestones'),
          hazMilestones, (milestones.length == 0) ? false : true);
    });
  }
   
  /****
   * Timer stuff.
   */
  // Starts the timer if it's off and there are milestones.
  void _startMilestoneTimer() {
    if (timer == null && milestones.length > 0) {
      // The timer goes off every second.
      var oneSecond = new Duration(seconds:1);
      timer = new Timer.periodic(oneSecond, _tick);
    }
  }
  
  // Turn off the timer if no milestones or they are all elapsed.
  void _stopMilestoneTimer(bool quitting) {
    if (quitting || (timer != null && milestones.where((m) => !m.elapsed).isEmpty)) {
      timer.cancel();
      timer = null;
    }
  }
  
  // Update the display for each milestone.
  void _tick(Timer _) {
    // For each milestone, update the time remaining...
    for (int i = 0; i < milestones.length; i++) {
      milestones[i].tick();
    }
  }
}