import 'package:expenses_planner_tricker/models/transaction-data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String txName;
  String amount;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool msgError = true;
  bool txNameMsgError = true;
  bool txDateError = true;
  DateTime selectedDate;

  void chooseDateTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      }
      setState(() {
        selectedDate = chosenDate;
        txDateError=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                errorText: txNameMsgError ? null : 'Transaction Name Empty',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo, width: 2),
                ),
                labelText: 'Transaction',
                labelStyle: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20.0,
                ),
              ),
              //controller: titleController,
              onChanged: (newValue) {
                setState(() {
                  txName = newValue;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: msgError ? null : 'InValid Number',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo, width: 2),
                ),
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color: Colors.indigo,
                  fontSize: 18.0,
                ),
              ),
              //controller: amountController,
              onChanged: (value) {
                setState(() {
                  amount = value;
                });
              },
            ),
            Container(
              height: 70.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date : ${DateFormat.yMMMd().format(selectedDate)}',
                      style: TextStyle(color: txDateError ? null : Colors.red),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: chooseDateTime,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                void showMsgError() {
                  setState(() {
                    msgError = false;
                  });
                }

                if (txName == null) {
                  setState(() {
                    txNameMsgError = false;
                  });
                }
                // else if (double.tryParse(amount) <= 0.0) {
                //   showMsgError();
                // }
                else if (selectedDate == null) {
                  setState(() {
                    txDateError = false;
                  });
                } else if (double.tryParse(amount) == null) {
                  showMsgError();
                } else {
                  Provider.of<TransactionsData>(context, listen: false)
                      .addTransaction(
                    txTitle: txName,
                    txAmount: double.parse(amount),
                    pickedDate: selectedDate,
                  );

                  //Provider.of<TransactionsData>(context, listen: false).encodedDataString;
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Transactions',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            )
          ],
        ),
      ),
    );
  }
}
