import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospisolve/models/Patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AuthServiceProvider extends ChangeNotifier {

  //plugins
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late SharedPreferences _prefs;

  late String _uid =_auth.currentUser!.uid,
      _firstname,
      _lastname,
      _email,
      _photo,
      _description = "",
      _gender = "Female",
      _handlename = "";

  late String _password ="";

  void setPassword(String p){
    _password = p;
        notifyListeners();
  }

  get email => _email;
  void setEmail(String v){
    _email=v;
    notifyListeners();
  }



  Future<bool> Signin() async {
    _prefs = await SharedPreferences.getInstance();
    try {
      String uid = await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) => value.user!.uid);
      if (uid.isNotEmpty) {
        //
        // Object? data = snap!.data();
        // Account? user =
        // Account.fromMap(convert.jsonDecode(convert.jsonEncode(data)));
        // await _prefs.setString("Patient", convert.jsonEncode(user.toMap()));
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> Signup({required String Password, required Patient patient}) async {
    UserCredential? reg = await _auth.createUserWithEmailAndPassword(
        email: patient.email, password: Password);

    // setUid(reg.user!.uid);
    // Account user = Account(
    //   description: "",
    //   firstname: firstname,
    //   lastname: lastname,
    //   email: email,
    //   gender: gender,
    //   handlename: "",
    //   photo: "",
    //   uid: uid,
    // );
    // await addUser(uid, user);

    return reg.user!.uid != null;
  }

}