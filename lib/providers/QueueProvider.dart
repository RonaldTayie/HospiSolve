import 'package:flutter/material.dart';
import 'package:hospisolve/models/Queue.dart';

class QueueProvider with ChangeNotifier {
  Queue? _queue;

  int? _queueNumber;
  String? _patientId;
  int? _counterNumber;
  String? _status;

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
}
