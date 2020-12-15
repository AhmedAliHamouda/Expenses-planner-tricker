import 'dart:io';
import 'package:expenses_planner_tricker/models/transaction-data.dart';
import 'package:provider/provider.dart';
import 'package:expenses_planner_tricker/widgits/add-transaction.dart';
import 'package:expenses_planner_tricker/widgits/chart-list.dart';
import 'package:expenses_planner_tricker/widgits/transactions-list.dart';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionsData>(context, listen:  false).getList();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state)  async{
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch(state){
      case  AppLifecycleState.paused :
        print('app Paused');
        break;
      case AppLifecycleState.detached :
        print('app Detached');
        break;
      case AppLifecycleState.inactive:
        //Provider.of<TransactionsData>(context, listen:  false).saveList();
        print(Provider.of<TransactionsData>(context, listen:  false).saveList());
        print('app Killed');

        break;
      case AppLifecycleState.resumed:
        print('app Resume');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBarForm = AppBar(
      title: Text('Expenses Planner'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                //return AddTransaction();
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTransaction(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBarForm,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: isLandScape
                    ? (MediaQuery.of(context).size.height -
                            appBarForm.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6
                    : (MediaQuery.of(context).size.height -
                            appBarForm.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                child: ChartList(),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBarForm.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.70,
                child: TransactionsList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS ? null: FloatingActionButton(
        //backgroundColor: Colors.indigo,
        elevation: 5,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              // return AddTransaction();
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTransaction(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
