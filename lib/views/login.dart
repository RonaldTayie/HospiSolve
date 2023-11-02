import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 31, 48, 1.0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 400,
              child: Center(
                child: SvgPicture.asset('assets/images/undraw_step_to_the_sun_nxqq 1.svg',semanticsLabel: "",fit: BoxFit.contain,) ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
               keyboardType: TextInputType.number,
               decoration: const InputDecoration(
                 fillColor: Color.fromRGBO(217, 217, 217, 0.5) ,
                 filled: true,
                 labelText: "ID Number : ",
                 labelStyle: TextStyle(
                   color: Colors.white,
                   fontSize: 20
                 ),
                 prefixIcon : Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8),
                   child: Icon(Icons.account_circle_outlined ,size: 30,color: Colors.white),
                 ),
                 border: OutlineInputBorder(
                     borderSide: BorderSide(
                         style: BorderStyle.solid,
                         width: 2,
                         color: Colors.white
                     ),
                     borderRadius: BorderRadius.all(Radius.circular(10))
                 ),
               ),
             ),
            ),
            const SizedBox (
              height: 200,
              width: double.infinity
            ),
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
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}
