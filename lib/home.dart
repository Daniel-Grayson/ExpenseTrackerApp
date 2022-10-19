import 'package:expense_tracker_app/plus_button.dart';
import 'package:expense_tracker_app/top_card.dart';
import 'package:expense_tracker_app/transactions.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // new transaction
  void _addTransaction() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("NEW TRANSACTIONS"),
            content: Text("Hey, Hello World"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          title: const Text(
            "EXPENSE TRACKER",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          )),
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        const TopCard(),
        const Expanded(
          child: Transactions(),
        ),
        PlusButton(
          function: _addTransaction,
        ),
      ]),
    );
  }
}
