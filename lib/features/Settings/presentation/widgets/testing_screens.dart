import 'package:flutter/material.dart';

class TestingScreens extends StatelessWidget {
  const TestingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("testing"),
      ),
      body: Center(
        child: Text("testing switch Screen"),
      ),
    );
  }
}
