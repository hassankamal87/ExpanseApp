import 'package:expanse/chart_bar.dart';
import 'package:expanse/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map> get groupTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].price;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum.toStringAsFixed(2));

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum.toStringAsFixed(2)
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransactionsValues.fold(0.0, (sum, item) {
      double ne = sum + double.parse(item['amount'].toString());
      return ne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(1),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionsValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(tx['day'], double.parse(tx['amount'].toString()),
                  double.parse(tx['amount'].toString()) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
