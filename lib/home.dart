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
  final listKey = GlobalKey();
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _purposeKey = GlobalKey<FormState>();
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
                            child: Form(
                              key: _purposeKey,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Purpose',
                                ),
                                validator: (purpose) {
                                  if (purpose == null || purpose.isEmpty) {
                                    return 'Field cannot be empty';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerITEM,
                              ),
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
                      if (_formKey.currentState!.validate() &&
                          _purposeKey.currentState!.validate()) {
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Transaction Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      )),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        // GoogleSheetsApi.currentTransactions.removeAt(
                        //   GoogleSheetsApi.currentTransactions[index]
                        // );

                        // balance = 0.0;
                        // check calculator logic to initialize balance, income and expenses to null on pressed
                      });
                    },
                    child: const Text('Clear All',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    color: Colors.black,
                  ),
                ],
              ),
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
                              key: listKey,
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
                                  onClicked: () => removeItem(index),
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

void removeItem(int index) {
  GoogleSheetsApi.currentTransactions.removeAt(index);

// var listKey;
  // listKey.currentState!.removeItem(index, );
}
