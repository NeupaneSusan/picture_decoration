import 'package:flutter/material.dart';
import 'package:picture_decoration/model/touch_pont.dart';

class BrushController with ChangeNotifier {
  final List<TouchPoints?> _touchPoint = [null];

  setTouchPoint(TouchPoints? points) {
    _touchPoint.add(points);
    notifyListeners();
  }

  undo() {
    print(_touchPoint);
    if (_touchPoint.length != 1) {
      for (int i = touchPoints.length-1; i > 0; i--) {
        if (touchPoints[i-1] != null) {
          _touchPoint.removeAt(i - 1);
           notifyListeners();
        } 
        else{
          _touchPoint.removeLast();
           notifyListeners();
          break;
        }

        print(_touchPoint);
      }
     
    }

    // if (_touchPoint.length > 2) {
    //   for (int i = _touchPoint.length; i > 0; i--) {
    //     if (_touchPoint[i - 2] != null) {
    //       _touchPoint.removeAt(i - 1);
    //     } else {
    //       // _touchPoint.removeLast();

    //       break;
    //     }

    //     print(_touchPoint);
    // notifyListeners();
    //   }
    // }
  }

  List<TouchPoints?> get touchPoints => _touchPoint;
}
