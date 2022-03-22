import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation(Colors.teal),
          strokeWidth: 6,
        ),
    );
  }
}