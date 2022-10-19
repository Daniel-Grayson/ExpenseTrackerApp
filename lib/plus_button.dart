import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Stack(alignment: Alignment.center, children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          height: 60,
          width: 60,
        ),
        const Icon(
          Icons.add_rounded,
          size: 35,
          color: Colors.white,
        ),
      ]),
    );
  }
}
