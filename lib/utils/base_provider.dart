import 'package:flutter/widgets.dart';

class BaseProvider with ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;

  set setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}

enum AppState { isLoaded, isProcessing, isNothing }
