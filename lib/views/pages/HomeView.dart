import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospisolve/providers/AuthServiceProvider.dart';
import 'package:hospisolve/providers/DoctorProvider.dart';
import 'package:hospisolve/widgets/PractitionerCard.dart';
import 'package:provider/provider.dart';

import '../../models/Doctor.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _HomeViewState extends State<HomeView> {

  SampleItem? selectedMenu;
  MenuController userMenuButtonController = MenuController();
  bool isUserMenuOpen = false;

  AuthServiceProvider _authServiceProvider = AuthServiceProvider();
  DoctorProvider _doctorProvider = DoctorProvider();
  @override
  void initState() {
    _doctorProvider.loadDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(4, 31, 48, 1.0),
            elevation: 0,
            expandedHeight: 280,
            collapsedHeight: 60,
            toolbarHeight: 60,
            floating: true,
            pinned: true,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _doctorProvider.loadDoctors();
                  },
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 30,
                    color: Colors.white,
                  )),
              MenuAnchor(
                builder: (context,MenuController userMenuButtonController, Widget? child)=>IconButton(
                    onPressed: (){
                      setState(() {
                        if(userMenuButtonController.isOpen){
                          userMenuButtonController.close();
                        }else{
                          userMenuButtonController.open();
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Colors.white,
                    )),
                menuChildren:  [
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: TextButton(onPressed: ()=>{}, child: const Text("View Profile")),
                  ),
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.itemTwo,
                    child: TextButton(onPressed: ()=>{
                      _authServiceProvider.logout().then((value) => {
                        Navigator.pushReplacementNamed(context, "/login")
                      })
                    }, child: const Text("Logout")),
                  ),
                ],
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: SvgPicture.asset(
                  'assets/images/undraw_empty_street_re_atjq.svg',
                  semanticsLabel: "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: true,
            child: FutureBuilder(
              future: _doctorProvider.getDoctors(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                    List<Doctor> doctors = snapshot.requireData;
                    return ListView.builder(
                      itemBuilder: (context,index){
                        return PractionerCard(full_name:doctors[index].practiceName,number:doctors[index].practiceNumber,department:doctors[index].department);
                      },itemCount: doctors.length,
                    );
                }else{
                  return Text("Loading");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
