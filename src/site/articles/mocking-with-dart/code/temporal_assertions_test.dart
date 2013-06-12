// #!/usr/bin/env dart_analyzer --enable_type_checks --extended-exit-code --type-checks-for-inferred-types

import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'dart:math';

class VendingMachineDispenser {
  
  List<int> inventory;
  
  VendingMachineDispenser(int numItems, int level) {
    restock(numItems, level);
  }
  
  void restock(int numItems, int level) {
    inventory = new List(numItems);
    for (var i = 0; i < numItems; i++) {
      inventory[i] = level;
    }
  }

  bool dispenseItem(int itemNumber) {
    if (itemNumber >= 0 && itemNumber < inventory.length &&
        inventory[itemNumber] > 0) {
      --inventory[itemNumber];
      return true;
    }
    return false;
  }
}


class VendingMachineCashier {
  
  static const int MaxCapacity = 50;
   
  VendingMachineDispenser _dispenser;
  List<int> _prices;
  int _deposited = 0;
  int numNickels = 0, numDimes = 0;

  int get deposited => _deposited;

  VendingMachineCashier(VendingMachineDispenser dispenser,
      List<int> prices)
      : _dispenser = dispenser,
        _prices = prices;
   
  String _depositCoin(int amount) {
    if (amount == 0 || _deposited > (MaxCapacity - amount)) {
      rejectCoin();
    } else {
      _deposited += amount;
    }
    return '${_deposited}c';
  }
   
  String depositNickel() => _depositCoin(5);   
  String depositDime() => _depositCoin(10);
  String depositOther() => _depositCoin(0);
   
  String selectItem(int itemNumber) {
    if (_deposited >=  _prices[itemNumber]) {
      // Make sure we have change.
      int change = deposited - _prices[itemNumber];
      if ((change % 10) == 5 && numNickels == 0) {
        giveChange(_deposited);
        _deposited = 0;
        return 'No change';
      } else if (_dispenser.dispenseItem(itemNumber)) {
        giveChange(change);
        _deposited = 0;
        return 'Insert coin';
      } else {
        giveChange(_deposited);
        _deposited = 0;
        return 'Item ${itemNumber} out';
      }
    }
    return '${_deposited}c';
  }
   
  String cancel() {
    giveChange(_deposited);
    _deposited = 0;
    return 'Insert coin';
  }
   
  void giveChange(int amount) {
    while (amount >= 10 && numDimes > 0) {
      --numDimes;
      dispenseDime();
      amount -= 10;
    }
    if (amount == 5) {
      --numNickels;
      dispenseNickel();
    }
  }
   
  // Hardware interface; stubs for now.   
  void rejectCoin() { /* Instruct hardware to reject current coin. */ }
  void dispenseNickel() { /* Instruct hardware to dispense nickel. */ }
  void dispenseDime() { /* Instruct hardware to dispense dime. */ }
}

//// Disliked by dartanalyzer
//class DispenserSpy extends Mock implements VendingMachineDispenser {
//  VendingMachineDispenser _real;
//
//  DispenserSpy(LogEntryList log, int numItems, int level)
//      : super.custom(name: 'dispenser', log: log),
//        _real = new VendingMachineDispenser(numItems, level) {
//    when(callsTo('dispenseItem')).alwaysCall(_real.dispenseItem);
//  }
//}
//
//// Disliked by dartanalyzer
//class CashierSpy extends Mock implements VendingMachineCashier {
//  VendingMachineCashier _real;
//
//  CashierSpy(LogEntryList log, VendingMachineDispenser d,
//      List<int>  prices)
//      : super.custom(name: 'cashier', log: log),
//        _real = new VendingMachineCashier(d, prices) {
//    when(callsTo('depositNickel')).alwaysCall(_real.depositNickel);
//    when(callsTo('depositDime')).alwaysCall(_real.depositDime);
//    when(callsTo('depositOther')).alwaysCall(_real.depositOther);
//    when(callsTo('selectItem')).alwaysCall(_real.selectItem);
//    when(callsTo('cancel')).alwaysCall(_real.cancel);
//    when(callsTo('get deposited')).alwaysCall(()=>_real.deposited);
//  }
//}

void main() {
  var rand = new Random();
  LogEntryList log = new LogEntryList();
  List<int> prices = [25, 40, 50 ];
//  var dispenser = new DispenserSpy(log, 3, 5);
//  var cashier = new CashierSpy(log, dispenser, prices);
  int numEvents = 500;
//  cashier.deposited; // useful for audit trail
//  while (--numEvents >= 0) {
//    var eNum = rand.nextInt(6);
//    switch (eNum) {
//      case 0:
//        cashier.depositNickel();
//        break;
//      case 1:
//        cashier.depositDime();
//        break;
//      case 2:
//        cashier.depositOther();
//        break;
//      default:
//        cashier.selectItem(eNum - 3);
//        break;
//    }
//    cashier.deposited; // useful for audit trail
//  }
  
  for (var item = 0; item < 3; item++) {
    int price = prices[item];
    // Get all calls to VendingMachineDispenser.dispenseItem that
    // returned true.
    LogEntryList dispenses = log.getMatches('dispenser',
        callsTo('dispenseItem', item), returning(isTrue));

    // Find the closest preceding calls to VendingMachineCashier.deposited.
    LogEntryList lastDeposits = log.preceding(dispenses,
        mockNameFilter: 'cashier', logFilter: callsTo('get deposited'));

    // Verify that the value returned was at least as high as item price.
    lastDeposits.verify(alwaysReturned(greaterThanOrEqualTo(price)));
  }
  
  
  for (var item = 0; item < 3; item++) {
    // Get the calls to selectItem that did not return ‘Insert coin’,
    // ‘No change’, or ‘Item nnn out’.
    LogEntryList failedDispenses = log.getMatches('cashier',
        callsTo('selectItem', item),
        returning(
            isNot(anyOf('Insert coin', 'No change', startsWith('Item')))));
    // Get the closest preceding calls to VendingMachineCashier.deposited.
    LogEntryList lastDeposits = log.preceding(failedDispenses,
        mockNameFilter: 'cashier', logFilter: callsTo('get deposited'));
    // Verify that the value returned was lower than the  item price.
    lastDeposits.verify(alwaysReturned(lessThan(prices[item])));
  }
  
  
  for (var item = 0; item < 3; item++) {
    // We query the logs for selectItem calls twice so save the
    // CallMatcher for reuse.
    CallMatcher selectItem = callsTo('selectItem', item);
    // Get the set of log entries where selectItem return no stock.
    LogEntryList noStockDispenses = log.getMatches('cashier',
        selectItem, returning('Item $item out'));
    // Get the set of log messages for selectItem that came
    // after the first no stock message.
    LogEntryList laterDispenses = log.fromFirst(noStockDispenses).
        getMatches('cashier', selectItem);
    // Verify that none of those returned success.
    laterDispenses.verify(neverReturned('Insert coin'));
  }
  
  
  for (var item = 0; item < 3; item++) {
    // Get the set of log entries where selectItem return no stock.
    LogEntryList noStockDispenses = log.getMatches('cashier',
        callsTo('selectItem', item), returning('Item $item out'));
    // Get the set of log messages for dispenseItem that came
    // after the first no stock message.
    LogEntryList laterDispenses = log.fromFirst(noStockDispenses).
        getMatches('dispenser', callsTo('dispenseItem', item));
    // Verify that none of those returned success.
    laterDispenses.verify(neverReturned(true));
  }
  
  
  // Get all calls to depositDime.
  LogEntryList dd = log.getMatches('cashier', callsTo('depositDime'));
  // Get the closest preceding calls to get deposited, and include
  // the calls to depositDime in the result.
  LogEntryList pairs = log.preceding(dd, mockNameFilter: 'cashier',
      logFilter: callsTo('get deposited'), includeKeys: true);
  // Our validator will operate on each pair, and return 0 upon failure or
  // 2 upon success (so we advance the position by 2 for the next call).
  pairs.stepwiseValidate((l, pos) =>
      (l[pos+1].value ==
       '${l[pos].value+(l[pos].value <= 40 ? 10 : 0)}c') ?
          2 : 0);
  /*
  when(callsTo('depositNickel')).
  alwaysCall(_real.depositNickel).logging = false;
  
  when(callsTo('depositNickel')).logging = false;
  when(callsTo(‘depositNickel’)).alwaysCall(_real.depositNickel);
  */
}
