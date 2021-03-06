import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:Xpense/widgets/new_transaction.dart';
import 'package:Xpense/widgets/transaction_list.dart';
import '../widgets/new_transaction.dart';
import '../widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: "t1", title: "Starbucks Coffee", amount: 250, date: DateTime.now()),
    // Transaction(
    // id: "t2", title: "New Shoes", amount: 3000, date: DateTime.now(),
    // )
  ];

  // A getter function to get the list of entries from 7 days before the current date
  List<Transaction> get _recentTransaction {
    return _userTransaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(
              days: 7,
            ),
          ),
        );
      },
    ).toList();
  }

  // List<Transaction> get _monthTransaction {

  //   return _userTransaction.where(
  //     (tx) {
  //     },
  //   ).toList();
  // }

  void _addTransaction(String addTitle, double addAmount) {
    Transaction(
        id: "id", title: addTitle, amount: addAmount, date: DateTime.now());
    final tx = Transaction(
        id: DateTime.now().toString(),
        title: addTitle,
        amount: addAmount,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(tx);
    });
  }


  void _startAddTx(BuildContext ctx) {
    // for the bottom overlay to add transaction
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xpense"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            onPressed: () {
              _startAddTx(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(_recentTransaction),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddTx(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
