import 'package:expanse/transactionList.dart';
import 'package:expanse/transactions.dart';
import 'package:flutter/material.dart';

import 'chart.dart';
import 'new_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [
    // Transaction(
    //     id: 't1',
    //     title: 'buy new phone',
    //     price: 69.88,
    //     date: DateTime.now().subtract(const Duration(days: 2))),
    // Transaction(
    //     id: 't2', title: 'buy new AirBods', price: 16.65, date: DateTime.now()),
  ];

  get recentTransactions {
      return transactions.where((tx) {
        return tx.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7)));
      }).toList();
  }

  void addNewTransaction(String title, double price, DateTime dateTime) {
    final newTX = Transaction(
        id: 't${transactions.length}',
        title: title,
        price: price,
        date: dateTime);

    setState(() {
      transactions.add(newTX);
    });
  }

  void deleteTransaction(Transaction t) {
    setState(() {
      transactions.remove(t);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addTX: addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Expanse App', style: TextStyle(fontFamily: 'Pac'),),
            actions: [
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(child: transactions.isNotEmpty ? Chart(recentTransactions) : null),
                TransactionList(transactions, deleteTransaction),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => startAddNewTransaction(context),
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}

// Center(
//                     child: Text(
//                   'No transactions added Yet!',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54),
//                 )),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: Container(
//                       height: 200,
//                       child: Image.asset(
//                         'images/waiting.png',
//                         fit: BoxFit.cover,
//                       )),
//                 )
