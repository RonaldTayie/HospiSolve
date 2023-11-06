import 'package:flutter/material.dart';
import 'package:hospisolve/models/Queue.dart';
import 'package:hospisolve/providers/QueueProvider.dart';
import 'package:hospisolve/views/GotoCounterView.dart';
import 'package:hospisolve/views/pages/HomeView.dart';
import 'package:hospisolve/views/pages/ProfileView.dart';
import 'package:provider/provider.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});
  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  late QueueProvider _queueProvider;
  final PageController _pageController = PageController();

  int currentNav = 0;
  @override
  void initState() {
    setState(() {
      _queueProvider = QueueProvider();
    });
    super.initState();
  }

  void updateNav(int page){
    setState(() {
      currentNav = page;
    });
  }
  
  void goToCounterMessage({required BuildContext context, required String counter}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GoToCounterView(message:counter)));
  }
  
  @override
  Widget build(BuildContext context) {
    var queueProvision = Provider.of<QueueProvider>(context);
    if(queueProvision.counterMessage!.isNotEmpty) {
      goToCounterMessage(context: context,counter: _queueProvider.counterMessage!);
    }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children:const [
          HomeView(),
          ProfileView()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:currentNav ,
        onTap: (i){
          updateNav(i);
          _pageController.animateToPage(i, duration: const Duration(milliseconds: 100), curve: Curves.linear);
        },
        backgroundColor: const Color.fromRGBO(4, 31, 48, .9),
        selectedItemColor: Theme.of(context).cardTheme.surfaceTintColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "profile"),
        ],
      ),
    );
  }
}
