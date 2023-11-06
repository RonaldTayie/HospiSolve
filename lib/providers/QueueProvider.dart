import 'package:flutter/material.dart';
import 'package:hospisolve/models/Queue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert' as convert;
import '../services/DataService.dart';

class QueueProvider with ChangeNotifier {
  Queue? _queue;

  String? _queueNumber;
  String? _patientId;
  String? _counterNumber;
  String? _status;
  String? _counterMessage = "";

  late final IOWebSocketChannel _channel;
  late SharedPreferences _prefs;



  final DataService _dataService = DataService();

  QueueProvider(){
    WebSocketProvider();
  }

  Queue? get queue => _queue;
  String? get queueNumber => _queueNumber;
  String? get patientId => _patientId;
  String? get counterNumber => _counterNumber;
  String? get status => _status;
  String? get counterMessage => _counterMessage;

  void setCounterMessage(String message){
    _counterMessage = message;
    notifyListeners();
  }

  void setQueue(Queue queue) {
    _queue = queue;
    _queueNumber = queue.queueNumber;
    _patientId = queue.patientId;
    _counterNumber = queue.counterNumber;
    _status = queue.status;
    notifyListeners();
  }

  void clearQueue() {
    _queue = null;
    _queueNumber = null;
    _patientId = null;
    _counterNumber = null;
    _status = null;
    notifyListeners();
  }

  void addToQueue() async {
    _prefs = await SharedPreferences.getInstance();
    String uid = _prefs.get("uid")!.toString();
    _dataService.networkPostRequest(url: "/queue/add/$uid", body: <String,dynamic>{}).then((value){
      getNextInQueue();
    });
  }

  void getNextInQueue() async {
    _prefs = await SharedPreferences.getInstance();
    String uid = _prefs.get("uid")!.toString();
    _dataService.networkGetRequest(url: "queue/getnext/FIuVqR227CWOdYGqiqj4m8EIVXb2").then((value) {
      if(value !=null && value !="retry"){
        Map<String,dynamic> data = convert.jsonDecode(value);
        if(data["data"]=="Queue Empty"){
          return;
        }
        setQueue(Queue.fromMap(data['data']["queue"]));
        notifyListeners();
      }else if(value=="retry"){
        getNextInQueue();
      }
    });
  }

  void WebSocketProvider() async {
    _prefs = await SharedPreferences.getInstance();
    String uid = _prefs.get("uid")!.toString();
    // _channel = IOWebSocketChannel.connect("ws://102.130.122.150:4001/?uuid=${uid}");
    _channel = IOWebSocketChannel.connect("wss://socketsbay.com/wss/v2/1/demo/");
    addToQueue();
    _channel.stream.listen((data) {
      setCounterMessage(data);
      notifyListeners();
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
    notifyListeners();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

}
