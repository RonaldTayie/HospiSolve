import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoToCounterView extends StatelessWidget {
  final String message;
  const GoToCounterView({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              child: Center(
                child: Text(message),
              ),
            )
          ],
        ),
      )
    );
  }
}
