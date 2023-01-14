import 'package:expanse/transactionList.dart';
import 'package:expanse/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chart.dart';
import 'new_transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'buy new phone',
        price: 69.88,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        id: 't2', title: 'buy new AirBods', price: 16.65, date: DateTime.now()),
  ];
  bool showChart = true;


  get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
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
    final appBar = AppBar(
      centerTitle: true,
      title: const Text(
        'Expanse App',
        style: TextStyle(fontFamily: 'Pac'),
      ),
      actions: [
        IconButton(
          onPressed: () => startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Builder(builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final bool isLandScape = Orientation.landscape == mediaQuery.orientation;
        final txListView =Container(
            height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.8,
            child: TransactionList(transactions, deleteTransaction));
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Expanse App',
              style: TextStyle(fontFamily: 'Pac'),
            ),
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
                if(isLandScape && transactions.isNotEmpty) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch.adaptive(value: showChart, onChanged: (val){
                      setState(() {
                        showChart = val;
                      });
                    })
                  ],
                ),
                if(isLandScape) transactions.isNotEmpty? showChart? Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                    child: Card(
                        child: Chart(recentTransactions))):txListView : txListView,
                if(!isLandScape) transactions.isNotEmpty ?Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.2,
                    child: Card(
                        child: Chart(recentTransactions))) : Container(),
                if(!isLandScape) txListView
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
