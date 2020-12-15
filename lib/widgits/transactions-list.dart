import 'package:expenses_planner_tricker/models/transaction-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // const bgColorList =[
    //   Colors.indigo,
    //   Colors.blue,
    //   Colors.blueAccent,
    //   Colors.indigoAccent
    // ];
    // setState(() {
    //   _bgColor=bgColorList[Random().nextInt(4)];
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsData>(
      builder: (context, txData, child) {
        return txData.transactions.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No Transactions added yet !! ',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: constraints.maxHeight*0.1),
                      Container(
                        height: constraints.maxHeight *0.6,
                        child: Image.asset(
                          'images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  );
                },
              )
            : ListView.builder(
                //shrinkWrap: true,
                //physics: ScrollPhysics(),
                itemCount: txData.transactionsNum,
                itemBuilder: (context, index) {
                  final transaction = txData.transactions[index];
                  final String dateFormatted =
                      DateFormat().add_yMMMd().format(transaction.dateTime);
                  return Card(
                    elevation: 5,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _bgColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: FittedBox(
                            child: Text(
                              '\$${transaction.amount.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        dateFormatted,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontSize: 15.0,
                          color: Colors.black54,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          setState(() {
                            txData.deleteTransaction(index);
                            //txData.transactions.removeWhere((element) => element.nameID ==transaction.nameID );
                          });
                        },
                      ),
                    ),

                    // child: Row(
                    //   children: [
                    //     Container(
                    //       child: Text(
                    //         '\$${transaction.amount.toStringAsFixed(2)}',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20.0,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       margin: EdgeInsets.symmetric(
                    //           vertical: 10, horizontal: 15),
                    //       padding: EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //         color: Colors.indigo,
                    //         borderRadius: BorderRadius.circular(10),
                    //         border: Border.all(
                    //           color: Colors.indigo,
                    //           width: 2,
                    //         ),
                    //       ),
                    //     ),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           transaction.title,
                    //           style: Theme.of(context).textTheme.headline6,
                    //         ),
                    //         Text(
                    //           dateFormatted,
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 15.0,
                    //             color: Colors.black54,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  );
                },
              );
      },
    );
  }
}
