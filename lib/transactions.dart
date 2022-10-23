import 'package:expense_tracker_app/google_sheets_api.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({
    Key? key,
    required this.transactionName,
    required this.expenseOrIncome,
    required this.money,
    // required this.onClicked
  }) : super(key: key);

  final String transactionName;
  final String expenseOrIncome;
  final String money;
  // final VoidCallback? onClicked;

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List users = [];
  int index = 0;
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
                      Text(widget.transactionName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Row(children: [
                    Text(
                      (widget.expenseOrIncome == "expense" ? "-" : "+") +
                          "\$" +
                          widget.money,
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.expenseOrIncome == "expense"
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: IconButton(
                          onPressed: deleteUser,
                          //  widget.onClicked,
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

  Future deleteUser() async {
    final user = users[index];

    await GoogleSheetsApi.deleteById(user.id!);
  }
}
