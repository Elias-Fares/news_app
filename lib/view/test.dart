import 'package:flutter/material.dart';

class Test extends StatelessWidget {
   Test({super.key});
  var x =
      "loremggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 50,
          child: Text(x)),
      ),
    );
  }
}
