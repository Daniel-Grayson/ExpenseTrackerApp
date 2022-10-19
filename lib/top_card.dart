import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50.0,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Container(
        height: 240,
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'B A L A N C E',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              '\$ 520.0',
              style: TextStyle(fontSize: 40, color: Colors.grey[800]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        height: 40,
                        width: 40,
                      ),
                      const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.green,
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Income',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '\$200.0',
                              style: TextStyle(
                                color: Color.fromARGB(255, 121, 120, 120),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        height: 40,
                        width: 40,
                      ),
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.red,
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Expense',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '\$500.0',
                              style: TextStyle(
                                color: Color.fromARGB(255, 121, 120, 120),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              )
            ]),
      ),
    );
  }
}
