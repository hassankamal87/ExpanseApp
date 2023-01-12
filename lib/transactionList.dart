import 'package:expanse/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty ? ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          elevation: 6,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                    child: Text(
                  '\$ ${transactions[index].price.toString()}',
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
            title: Text(
              transactions[index].title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
                DateFormat.yMMMMEEEEd().format(transactions[index].date)),
            trailing: IconButton(
              onPressed: () {
                deleteTransaction(transactions[index]);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.purple,
              ),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    ) : LayoutBuilder(builder: (ctx, constraints){
      return Column(children: [
        Center(
            child: Text(
              'No transactions added Yet!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'images/waiting.png',
                fit: BoxFit.cover,
              )),
        )
      ],
      );
    });
  }
}

//Card(
//             child: Row(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 15,
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.purple,
//                       width: 2,
//                     ),
//                   ),
//                   child: Text(
//                     '\$${transactions[index].price.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Colors.purple),
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       transactions[index].title,
//                       style: const TextStyle(
//                           fontSize: 16.0, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       DateFormat.yMMMMEEEEd().format(transactions[index].date),
//                       style: const TextStyle(
//                           fontSize: 10.0, color: Colors.grey),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           );
