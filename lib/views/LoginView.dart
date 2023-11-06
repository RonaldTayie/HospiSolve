import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hospisolve/views/BaseView.dart';
import 'package:provider/provider.dart';

import '../providers/AuthServiceProvider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _authProvider = AuthServiceProvider();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {

    emailController = new TextEditingController();
    passwordController = new TextEditingController();

    super.initState();
  }

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
                controller: emailController,
               keyboardType: TextInputType.emailAddress,
               decoration: const InputDecoration(
                 fillColor: Color.fromRGBO(217, 217, 217, 0.5) ,
                 filled: true,
                 labelText: "Email",
                 labelStyle: TextStyle(
                   color: Colors.white,
                   fontSize: 20
                 ),
                 prefixIcon : Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8),
                   child: Icon(Icons.email_outlined ,size: 30,color: Colors.white),
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
                onChanged: (e){
                  _authProvider.setEmail(e.toString());
                }
             ),
            ),
            const SizedBox (
                height: 30,
                width: double.infinity
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:  TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(217, 217, 217, 0.5) ,
                  filled: true,
                  labelText: "Password",
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                  ),
                  prefixIcon : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.lock ,size: 30,color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 2,
                          color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (p){
                  _authProvider.setPassword(p.toString());
                },
              ),
            ),
            const SizedBox (
              height: 20,
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
                onPressed: (){
                  _authProvider.Signin().then((value) {
                    if(value==true){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Success") ,elevation: 5,showCloseIcon: false,));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed, please check your credentials.",style: TextStyle(color: Colors.white)) ,elevation: 5,showCloseIcon: false,backgroundColor: Colors.red,));
                    }
                  });
                },
              ),
            ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0,20,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Do not have an account?",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700),),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700,),
                  )
                )
              ],
            )
        )
          ],
        ),
      ),
    );
  }
}
