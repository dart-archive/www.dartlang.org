library milestone;

import 'package:polymer/polymer.dart';
import 'dart:async';
import 'dart:html';
import 'dart:indexed_db';

/*
 * The MODEL for the app.
 * 
 * Contains two classes:
 * Milestone to hold info for an individual milestone.
 * MilestoneStore to manage a list of milestones in memory
 * and in the IndexedDB.
 */

/****
 * A class to hold the info for an individual milestone.
 */
class Milestone extends ChangeNotifierBase {
  final String milestoneName;
  final DateTime happensOn;
  var dbKey;
  
  Duration timeRemaining = new Duration();
  @observable String get timeRemainingAsString => __$timeRemainingAsString; String __$timeRemainingAsString; set timeRemainingAsString(String value) { __$timeRemainingAsString = notifyPropertyChange(#timeRemainingAsString, __$timeRemainingAsString, value); }
  
  Milestone(this.milestoneName, this.happensOn);
  
  String toString() => '$milestoneName $happensOn';
  
  // Constructor which creates a milestone
  // from the value (a Map) stored in the database.
  Milestone.fromRaw(key, Map value):
    dbKey = key,
    milestoneName = value['milestoneName'],
    happensOn = DateTime.parse(value['happensOn']) {
    tick();
  }
  
  // Serialize this to an object (a Map) to insert into the database.
  Map toRaw() {
    return {
      'milestoneName': milestoneName,
      'happensOn': happensOn.toString(),
    };
  }
  
  bool get elapsed {
    return new DateTime.now().isAfter(happensOn);
  }
  
  // Called from the VIEW-MODEL to update the time remaining.
  void tick() {
    timeRemaining = happensOn.difference(new DateTime.now());
    timeRemainingAsString = formatTimeRemainingAsString();
  }
  
  // This should really be in the VIEW
  String formatTimeRemainingAsString() {
    String _displayString;
    
    if (elapsed) {
      _displayString = 'Huzzah for ${milestoneName}!';
      return _displayString;
    }
    
    // Calculate days, hours, and minutes remaining.
   // Duration timeRemaining = milestone.timeRemaining;
    
    int d = timeRemaining.inDays;
    int h = timeRemaining.inHours.remainder(Duration.HOURS_PER_DAY);
    int m = timeRemaining.inMinutes.remainder(Duration.MINUTES_PER_HOUR);
    int s = timeRemaining.inSeconds.remainder(Duration.SECONDS_PER_MINUTE);
    
    // Format individual pieces of the display string.
    String days = (d == 0) ? '' : '$d days, ';
    String hours = (h == 0) ? '' : '$h hours, ';
    String minutes = (m == 0) ? '' : '$m minutes, ';
    String seconds = '$s seconds';
    
    _displayString = '$days $hours $minutes $seconds until ${milestoneName}';
    return _displayString;
  }}

/****
 * A class to manage a list of milestones in memory
 * and in an IndexedDB.
 */
class MilestoneStore {
  static const String MILESTONE_STORE = 'milestoneStore';
  static const String NAME_INDEX = 'name_index';
  
  final List<Milestone> milestones = toObservable(new List());
  
  Database _db;
  
  Future open() {
    return window.indexedDB.open('milestoneDB',
        version: 1,
        onUpgradeNeeded: _initializeDatabase)
      .then(_loadFromDB);
  }
  
  // Initializes the object store if it is brand new,
  // or upgrades it if the version is older. 
  void _initializeDatabase(VersionChangeEvent e) {
    Database db = (e.target as Request).result;
    
    var objectStore = db.createObjectStore(MILESTONE_STORE,
        autoIncrement: true);
    
    // Create an index to search by name,
    // unique is true: the index doesn't allow duplicate milestone names.
    objectStore.createIndex(NAME_INDEX, 'milestoneName', unique: true);
  }
  
  // Loads all of the existing objects from the database.
  // The future completes when loading is finished.
  Future _loadFromDB(Database db) {
    _db = db;
    
    var trans = db.transaction(MILESTONE_STORE, 'readonly');
    var store = trans.objectStore(MILESTONE_STORE);
    
    // Get everything in the store.
    var cursors = store.openCursor(autoAdvance: true).asBroadcastStream();
    cursors.listen((cursor) {
      // Add milestone to the internal list.
      var milestone = new Milestone.fromRaw(cursor.key, cursor.value);
      milestones.add(milestone);

    });
    return cursors.length.then((_) {
      return milestones.length;
    });
  }
  
  // Add a new milestone to the milestones in the Database.
  // 
  // This returns a Future with the new milestone when the milestone
  // has been added.
  Future<Milestone> add(String milestoneName, DateTime occursOn) {
    var milestone = new Milestone(milestoneName, occursOn);
    var milestoneAsMap = milestone.toRaw();

    var transaction = _db.transaction(MILESTONE_STORE, 'readwrite');
    var objectStore = transaction.objectStore(MILESTONE_STORE);
    
    objectStore.add(milestoneAsMap).then((addedKey) {
      // NOTE! The key cannot be used until the transaction completes.
      milestone.dbKey = addedKey;
    });
    
    // Note that the milestone cannot be queried until the transaction
    // has completed!
    return transaction.completed.then((_) {
      // Once the transaction completes, add it to our list of available items.
      milestones.add(milestone);
      
      // Return the milestone so this becomes the result of the future.
      return milestone;
    });
  }
  
  // Removes a milestone from the list of milestones.
  // 
  // This returns a Future which completes when the milestone has been removed.
  Future remove(Milestone milestone) {
    // Remove from database.
    var transaction = _db.transaction(MILESTONE_STORE, 'readwrite');
    transaction.objectStore(MILESTONE_STORE).delete(milestone.dbKey);
    
    return transaction.completed.then((_) {
      // Null out the key to indicate that the milestone is dead.
      milestone.dbKey = null;
      // Remove from internal list.
      milestones.remove(milestone);
    });
  }
  
  // Removes ALL milestones.
  Future clear() {
    // Clear database.
    var transaction = _db.transaction(MILESTONE_STORE, 'readwrite');
    transaction.objectStore(MILESTONE_STORE).clear();
    
    return transaction.completed.then((_) {
      // Clear internal list.
      milestones.clear();
    });
  }
}
