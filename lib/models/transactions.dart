import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Transactions {
  final String nameID;
  final String title;
  final double amount;
  final DateTime dateTime;

  Transactions({
     this.nameID,
    @required this.title,
    @required this.amount,
    @required this.dateTime,
  });

  factory Transactions.fromJson(Map<String,Object> jsonData){
    DateTime dateTime=DateTime.parse(jsonData['dateTime']);
    return Transactions(
      title: jsonData['title'],
      amount: jsonData['amount'],
      dateTime: dateTime,
      nameID: jsonData['dateTime'].toString(),
    );
  }
}
