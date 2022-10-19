import 'package:expense_tracker_app/plus_button.dart';
import 'package:expense_tracker_app/top_card.dart';
import 'package:expense_tracker_app/transactions.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(children: const [
        TopCard(),
        Expanded(
          child: Transactions(),
        ),
        PlusButton(),
      ]),
    );
  }
}
