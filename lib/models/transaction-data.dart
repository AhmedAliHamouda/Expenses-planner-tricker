import 'dart:convert';

import 'package:expenses_planner_tricker/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsData extends ChangeNotifier {
  SharedPreferences prefs;
  //TODO: this List of Class Object
  List<Transactions> transactions = [
    // Transactions(
    //   nameID: 't1',
    //   title: 'trousers',
    //   amount: 120.5,
    //   dateTime: DateTime.now(),
    // ),
  ];
  List<Transactions> testList = [];

  //final List<Transactions> txTest = [];

  //TODO: this List Of Map
  //List<Map<String, Object>> tx2 = [];

  List<Map<String, Object>> get groupedTransactions {
    List<Transactions> recentTransactions = transactions.where(
      (element) {
        return element.dateTime.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();

    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].dateTime.day == weekDay.day &&
              recentTransactions[i].dateTime.month == weekDay.month &&
              recentTransactions[i].dateTime.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  int get transactionsNum {
    return transactions.length;
  }

  void addTransaction({String txTitle, double txAmount, DateTime pickedDate}) {
    transactions.add(
      Transactions(
        title: txTitle,
        amount: txAmount,
        dateTime: pickedDate,
        nameID: pickedDate.toString(),
      ),
    );
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }

  //TODO: save Data to local memory by using SharedPreferences


  static Map<String, dynamic> toMap(transactionsData) {
    return {
      'title': transactionsData.title,
      'amount': transactionsData.amount,
      'dateTime': transactionsData.dateTime.toString(),
      'nameID': transactionsData.dateTime.toString(),
    };
  }

  static String encodeData(List<Transactions> tsList) {
    return json
        .encode(tsList.map<Map<String, dynamic>>((e) => toMap(e)).toList());
  }

  List<Transactions> decodedData(String dataCoded) {
    return (json.decode(dataCoded) as List<dynamic>)
        .map<Transactions>((e) => Transactions.fromJson(e))
        .toList();
  }

  Future<bool> saveList() async {
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
    return await prefs.setString(
        'dataOfTransactions', encodeData(transactions));
  }

  Future<void> getList() async {
    prefs = await SharedPreferences.getInstance();
    String getData = prefs.getString('dataOfTransactions');
    transactions = decodedData(getData);
    notifyListeners();
  }

  // void addTx2({String txTitle, double txAmount, String pickedDate}) {
  //   tx2.add({
  //     'title': txTitle,
  //     'amount': txAmount,
  //     'dateTime': pickedDate.toString(),
  //     'nameID': pickedDate.toString(),
  //   });
  //
  //   // print(tx2);
  //   notifyListeners();
  // }
  //
  // void get ourSavedData {
  //   var s = json.encode(transactions);
  //   var ss = json.decode(s);
  //   print(s);
  //   notifyListeners();
  // }
  //
  // void addDataToMainList() {
  //   for (var i = 0; i < tx2.length; i++) {
  //     txTest.add(Transactions(
  //       title: tx2[i]['title'],
  //       amount: tx2[i]['amount'],
  //       dateTime: tx2[i]['dateTime'],
  //       nameID: tx2[i]['nameID'],
  //     ));
  //   }
  // }
  //
  // List<Map<String, Object>> get groupTx2 {
  //   List<Map<String, Object>> recentTx2 = tx2.where(
  //     (element) {
  //       DateTime dateTime = DateTime.parse(element['dateTime']);
  //       return dateTime.isAfter(
  //         DateTime.now().subtract(
  //           Duration(days: 7),
  //         ),
  //       );
  //     },
  //   ).toList();
  //   //print(recentTx2);
  //   return List.generate(
  //     7,
  //     (index) {
  //       final weekDay = DateTime.now().subtract(Duration(days: index));
  //       double totalSum = 0.0;
  //       for (var i = 0; i < recentTx2.length; i++) {
  //         DateTime dateTime2 = DateTime.parse(recentTx2[i]['dateTime']);
  //         if (dateTime2.day == weekDay.day &&
  //             dateTime2.month == weekDay.month &&
  //             dateTime2.year == weekDay.year) {
  //           totalSum += recentTx2[i]['amount'];
  //         }
  //       }
  //       return {
  //         'day': DateFormat.E().format(weekDay).substring(0, 1),
  //         'amount': totalSum,
  //       };
  //     },
  //   ).reversed.toList();
  // }
}
