import 'package:flutter/material.dart';
import 'package:hospisolve/models/Queue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../services/DataService.dart';

class QueueProvider with ChangeNotifier {
  Queue? _queue;

  int? _queueNumber;
  String? _patientId;
  int? _counterNumber;
  String? _status;

  late final IOWebSocketChannel _channel;
  late SharedPreferences _prefs;

  final DataService _dataService = DataService();

  QueueProvider(){
    WebSocketProvider();
  }

  Queue? get queue => _queue;
  int? get queueNumber => _queueNumber;
  String? get patientId => _patientId;
  int? get counterNumber => _counterNumber;
  String? get status => _status;

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
    _dataService.networkGetRequest(url: "queue/getnext/$uid").then((value) => {
      print(value)
    });
  }

  void WebSocketProvider() async {
    _prefs = await SharedPreferences.getInstance();
    String uid = _prefs.get("uid")!.toString();
    _channel = IOWebSocketChannel.connect("ws://102.130.122.150:4001/?uuid=${uid}`");
    addToQueue();
    notifyListeners();
    _channel.stream.listen((data) {
      print('Received message: $data');
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
    notifyListeners();
  }


}
