import 'package:flutter/foundation.dart';
import 'package:request_craft/request/request_model.dart';

class RequestProvider with ChangeNotifier {
  RequestModel? _selectedRequest;
  RequestModel? get selectedRequest => _selectedRequest;



  void setSelectedRequest(RequestModel model) {
    _selectedRequest = model;

    notifyListeners();
  }

}
