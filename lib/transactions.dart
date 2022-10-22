import 'package:flutter/material.dart';

import 'google_sheets_api.dart';

class Transactions extends StatelessWidget {
  const Transactions(
      {Key? key,
      required this.transactionName,
      required this.expenseOrIncome,
      required this.money})
      : super(key: key);

  final String transactionName;
  final String expenseOrIncome;
  final String money;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(transactionName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Row(children: [
                    Text(
                      (expenseOrIncome == "expense" ? "-" : "+") + "\$" + money,
                      style: TextStyle(
                        fontSize: 16,
                        color: expenseOrIncome == "expense"
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: IconButton(
                          onPressed: () {
                            GoogleSheetsApi.currentTransactions.length - 1;
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ])
                ]),
          ),
        ));
  }
}
