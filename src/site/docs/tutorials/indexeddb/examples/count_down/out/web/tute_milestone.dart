import 'package:polymer/polymer.dart';
import 'milestone.dart';
import 'count_down.dart';
import 'dart:html';

@CustomTag('tute-milestone')
class MilestoneComponent extends PolymerElement {
  @observable Milestone get milestone => __$milestone; Milestone __$milestone; set milestone(Milestone value) { __$milestone = notifyPropertyChange(#milestone, __$milestone, value); }
  @observable String _displayString = '';
    
  // xx: Internationalize this.
  //getters aren't automatically observed...so moved this method into the milestone object
  //and observe that instead.
  @observable String get timeRemainingAsString { 
    if (milestone.elapsed) {
      _displayString = 'Huzzah for ${milestone.milestoneName}!';
      return _displayString;
    }
    
    // Calculate days, hours, and minutes remaining.
    Duration timeRemaining = milestone.timeRemaining;
    
    int d = timeRemaining.inDays;
    int h = timeRemaining.inHours.remainder(Duration.HOURS_PER_DAY);
    int m = timeRemaining.inMinutes.remainder(Duration.MINUTES_PER_HOUR);
    int s = timeRemaining.inSeconds.remainder(Duration.SECONDS_PER_MINUTE);
    
    // Format individual pieces of the display string.
    String days = (d == 0) ? '' : '$d days, ';
    String hours = (h == 0) ? '' : '$h hours, ';
    String minutes = (m == 0) ? '' : '$m minutes, ';
    String seconds = '$s seconds';
    
    _displayString = '$days $hours $minutes $seconds until ${milestone.milestoneName}';
    return _displayString;
  }

  void removeMilestone(Event e, var detail, Node target) {
    appObject.removeMilestone(milestone);
  }
}