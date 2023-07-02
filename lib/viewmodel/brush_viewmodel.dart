import 'package:flutter/material.dart';
import 'package:picture_decoration/model/touch_pont.dart';

class BrushController with ChangeNotifier {
  final List<TouchPoints?> _touchPoint = [null];
  final List<TouchPoints?> _erasetouchPoint = [null];

  double widthStock = 4;
  void setTouchPoint(TouchPoints? points) {
    _touchPoint.add(points);
    notifyListeners();
  }

  void setEraseTouchPoint(TouchPoints? points) {
    _erasetouchPoint.add(points);
    notifyListeners();
  }

  void undo() {
    if (_touchPoint.length != 1) {
      for (int i = touchPoints.length - 1; i > 0; i--) {
        if (touchPoints[i - 1] != null) {
          _touchPoint.removeAt(i - 1);
          notifyListeners();
        } else {
          _touchPoint.removeLast();
          notifyListeners();
          break;
        }
      }
    }
  }

  set widthStockValue(double value) {
    widthStock = value;
    notifyListeners();
  }

  List<TouchPoints?> get touchPoints => _touchPoint;
  List<TouchPoints?> get eraseTouchPoints => _erasetouchPoint;
}
