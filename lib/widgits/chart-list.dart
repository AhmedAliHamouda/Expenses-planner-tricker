import 'package:expenses_planner_tricker/models/transaction-data.dart';
import 'package:expenses_planner_tricker/widgits/chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartList extends StatefulWidget {
  @override
  _ChartListState createState() => _ChartListState();
}

class _ChartListState extends State<ChartList> {
  List<Map<String, Object>> recentTransactions;
  double totalSpendingData;
  @override
  Widget build(BuildContext context) {
    recentTransactions =
        Provider.of<TransactionsData>(context).groupedTransactions;
    totalSpendingData=Provider.of<TransactionsData>(context).totalSpending;

    // return Card(
    //   elevation: 5,
    //   margin: EdgeInsets.all(15),
    //   child: Consumer<TransactionsData>(builder: (context, txData, child) {
    //     return ListView.builder(
    //       shrinkWrap: true,
    //       scrollDirection: Axis.horizontal,
    //       itemCount: txData.groupedTransactions.length,
    //       itemBuilder: (context, index) {
    //         final recentData = txData.groupedTransactions[index];
    //         return Row(
    //           children: [
    //             ChartBar(
    //               label: recentData['day'],
    //               spendingAmount: recentData['amount'],
    //               spendingTotal:  txData.totalSpending == 0.0 ? 0.0 :(recentData['amount']  as double ) / txData.totalSpending,
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   }),
    // );
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: recentTransactions.map((recentData) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: recentData['day'],
                spendingAmount: recentData['amount'],
                spendingTotal: totalSpendingData== 0.0
                    ? 0.0
                    : (recentData['amount'] as double) / totalSpendingData,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
