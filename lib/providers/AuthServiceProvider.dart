import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospisolve/models/Patient.dart';
import 'package:hospisolve/services/DataService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class AuthServiceProvider extends ChangeNotifier {

  final DataService _dataService = DataService();
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


  Future<bool> logout() async{
    _prefs = await SharedPreferences.getInstance();
    await _auth.signOut().then((value) {
      _prefs.remove("uid");
      _prefs.remove("token");
      _prefs.remove("patient");
    });
    return true;
  }

  Future<bool> Signin() async {
    _prefs = await SharedPreferences.getInstance();
    try {
      String uid = await _auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) async {
            _prefs.setString("uid",value.user!.uid );
            await value.user!.getIdToken(true).then((tk)=>{
              if(tk!=null){
                _prefs.setString("token", tk)
              }
            });
            return value.user!.uid;
          });
      if (uid.isNotEmpty) {
        return await getSignedInPatient(uid: uid).then((v){
          print(v);
          return v!=null;
        });

      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Patient?> getSignedInPatient({required String uid}) async {
    return _dataService.networkGetRequest( url: "/patient/getprofile/$uid").then((value)  {
      print(value);
    });

  }
  Future<bool> _registerNewPatient({required String uid, required Map<String,dynamic> data, required String token}) async {
    return await _dataService.networkPostRequest( url: "patient/createprofile/${uid}",body:data).then((value){
      print(convert.jsonEncode(data));
      if(value!=null){
        _dataService.writeData(key: "patient", value: value);
        return true;
      }else{
        // Save an instance of the user to SharedPreferences. TODO Remove once main is working
        _dataService.writeData(key: "patient", value: convert.jsonEncode(data));
        return true;
      }
    });
  }

  Future<bool> Signup({required String Password, required Patient patient}) async {
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get("token")!.toString();
    String uid = _prefs.get("uid")!.toString();

    return await _auth.createUserWithEmailAndPassword(email: patient.email, password: Password).then((value) async {
      return value.user!.getIdToken(true).then((token) async {
        if(token!=null){
          String uid = value.user!.uid;
          _prefs.setString("uid",uid);
          _prefs.setString("token", token as String);
          return await _registerNewPatient(data: patient.toMap(), token: token, uid:uid);
        }else{
          return false;
        }
      });
    });
  }

}