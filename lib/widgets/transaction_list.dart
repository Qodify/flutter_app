import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTx;

  TransactionList(this._transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          : ListView.builder(
              //has infinite height
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child: Text('\$${_transactions[index].amount}')),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => _deleteTx(_transactions[index].id),
                      ),
                      title: Text(_transactions[index].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_transactions[index].date),
                      )),
                );
              },
              itemCount: _transactions.length,
            ),
    );
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
