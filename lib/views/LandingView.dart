import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Center(
              child: SvgPicture.asset('assets/images/undraw_step_to_the_sun_nxqq 1.svg',semanticsLabel: "",fit: BoxFit.contain,) ,
            ),
          ),
          const Spacer(flex: 5,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: MaterialButton(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2,),
                  Text(
                    "Continue",
                    style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor ),
                  ),
                  const Spacer(flex: 1,),
                  Icon(Icons.chevron_right,size:35,color: Theme.of(context).primaryColor,),
                  const Spacer(flex: 1,),
                ],
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          )
        ],
      ),
    );
  }
}
