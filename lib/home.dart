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
  // collect user input
  bool _isIncome = false;

  // enter new transaction into spreadsheet
  void _enterTransaction() {
    _isIncome;
  }

  // new transaction
  void _addTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Center(
                child: Text("NEW TRANSACTIONS"),
              ),
              content: SingleChildScrollView(
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Expense"),
                        Switch(
                          inactiveThumbColor: Colors.red,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              _isIncome = value;
                            });
                          },
                          value: _isIncome,
                        ),
                        const Text("Income"),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Amount',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Purpose',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.black,
                          child: const Text('Cancel',
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: MaterialButton(
                            onPressed: () {},
                            color: Colors.black,
                            child: const Text(
                              'Enter',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          });
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
        const TopCard(
          balance: '500',
          expense: '250',
          income: '490',
        ),
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
