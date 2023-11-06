import 'dart:async';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';
import 'NotificationManager.dart';
import 'package:http/http.dart' as http;

class DataService {
  // plugins
  late SharedPreferences _prefs;
  final NotificationManager _notificationManager = NotificationManager();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // is Connected variable
  Future<bool> isConnected() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  // Init because the constructor an not be async
  init() async {
    _prefs = await SharedPreferences.getInstance();
    // await isConnected() ? pushNewAppended() : null;
  }
  //constructor
  DataService(){
  }

  Future<String?> networkGetRequest({required String url}) async {
    _prefs = await SharedPreferences.getInstance();
    return http.get(Uri.http(host,url),headers: { "Authorization":"Bearer ${_prefs.get("token")}" }).then((value){
      if(value.statusCode==401){
        refreshToken();
        return "retry";
      }
      return value.body;
    });
  }

  Future<String?> networkPostRequest({required String url,required Map<String,dynamic> body}) async {
    _prefs = await SharedPreferences.getInstance();
    final String token = _prefs.get("token")!.toString();
    return http.post(Uri.http(host,url),headers: { "Authorization":"Bearer ${token}" },body: body).then((value){
      if(value.statusCode==401){
        refreshToken();
        return "retry";
      }
      return value.statusCode==200||value.statusCode==201?convert.jsonEncode(value.body):null;
    });
  }

  Future<String> refreshToken() async {
    String token = await _auth.currentUser!.getIdToken(false).then((value) => value!);
    if(token!=null){
      writeData(key: "token", value: token);
      return token;
    }else{
      return "";
    }
  }

  Future<void> writeData({ required String key, required String value }) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  Future<void> writeDataList({ required String key, required List<String> value }) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(key, value);
  }

  Future<String?> readData({required String key}) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<List<String>?> readDataList({required String key}) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(key);
  }

}