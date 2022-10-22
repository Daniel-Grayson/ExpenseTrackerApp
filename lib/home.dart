// import 'package:expense_tracker_app/plus_button.dart';
// import 'package:expense_tracker_app/top_card.dart';
// import 'package:expense_tracker_app/transactions.dart';
// import 'package:flutter/material.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // collect user input
//   bool _isIncome = false;

//   // enter new transaction into spreadsheet
//   void _enterTransaction() {
//     _isIncome;
//   }

//   // new transaction
//   void _addTransaction() {
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(builder: (BuildContext context, setState) {
//             return AlertDialog(
//               title: const Center(
//                 child: Text("NEW TRANSACTIONS"),
//               ),
//               content: SingleChildScrollView(
//                 child: Column(children: [
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const Text("Expense"),
//                         Switch(
//                           inactiveThumbColor: Colors.red,
//                           activeColor: Colors.green,
//                           onChanged: (bool value) {
//                             setState(() {
//                               _isIncome = value;
//                             });
//                           },
//                           value: _isIncome,
//                         ),
//                         const Text("Income"),
//                       ]),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Amount',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Purpose',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       MaterialButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           color: Colors.black,
//                           child: const Text('Cancel',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ))),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: MaterialButton(
//                             onPressed: () {},
//                             color: Colors.black,
//                             child: const Text(
//                               'Enter',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ]),
//               ),
//             );
//           });
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.grey[300],
//           centerTitle: true,
//           title: const Text(
//             "EXPENSE TRACKER",
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey,
//             ),
//           )),
//       backgroundColor: Colors.grey[200],
//       body: Column(children: [
//         const TopCard(
//           balance: '500',
//           expense: '250',
//           income: '490',
//         ),
//         const Expanded(
//           child: Transactions(
//             expenseOrIncome: 'income',
//             money: '5000',
//             transactionName: 'School fees',
//           ),
//         ),
//         PlusButton(
//           function: _addTransaction,
//         ),
//       ]),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transactions.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyApp> {
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Center(
                    child: Text(
                  'NEW TRANSACTION',
                )),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Expense'),
                          Switch(
                            inactiveThumbColor: Colors.red,
                            activeColor: Colors.green,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          const Text('Income'),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Purpose',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  MaterialButton(
                    color: Colors.black,
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.black,
                    child: const Text('Enter',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

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
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TopCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GoogleSheetsApi.loading == true
                          ? const LoadingCircle()
                          : ListView.builder(
                              itemCount:
                                  GoogleSheetsApi.currentTransactions.length,
                              itemBuilder: (context, index) {
                                return Transactions(
                                  transactionName: GoogleSheetsApi
                                      .currentTransactions[index][0],
                                  money: GoogleSheetsApi
                                      .currentTransactions[index][1],
                                  expenseOrIncome: GoogleSheetsApi
                                      .currentTransactions[index][2],
                                );
                              }),
                    )
                  ],
                ),
              ),
            ),
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }
}
