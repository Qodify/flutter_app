import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;

  TransactionList(this._transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            // text image ZZZ
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                      color: Colors.grey,
                    ),
                  )
                ],
              );
            },
          )
        : ListView(
            children: _transactions
                .map((tx) => TransactionItem(
                  key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTx: _deleteTx,
                    ))
                .toList(),

            //itemCount: _transactions.length,
          );

    //has infinite height
  }
}

// class ListCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return return Card(
//                   //margin: EdgeInsets.all(10),
//                   elevation: 3,
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Theme.of(context).primaryColor,
//                             width: 2,
//                           ),
//                         ),
//                         child: Text(
//                           '\$ ${_userTransactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                         padding: EdgeInsets.all(5),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(_userTransactions[index].title,
//                               style: Theme.of(context).textTheme.title),
//                           Text(
//                             DateFormat.yMMMd()
//                                 .format(_userTransactions[index].date),
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//   }
// }
