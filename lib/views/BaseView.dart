import 'package:flutter/material.dart';
import 'package:hospisolve/views/pages/HomeView.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});
  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        HomeView()
      ],),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "profile"),
        ],
      ),
    );
  }
}
