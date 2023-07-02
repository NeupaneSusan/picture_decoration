import 'package:flutter/material.dart';
import 'package:picture_decoration/model/kfont_style_model.dart';

class TextProcess with ChangeNotifier {
  final List<KfontStyleModel> _textList = [];
  int _selectedTextIndex = -1;
  void setText({
    required String title,
    required TextStyle textStyle,
    required double left,
    required double top,
  }) {
    KfontStyleModel p = KfontStyleModel(
      title: title,
      textStyle: textStyle,
      left: left,
      top: top,
    );
    _textList.add(p);
    _selectedTextIndex = _textList.length - 1;
    notifyListeners();
  }

  void setPositionText(
      {required double left,
      required double top,
      required double scale,
      required double rotate,
      required int index}) {
    double oLeft = _textList[index].left;
    double oTop = _textList[index].top;
    double obaseScaleFactor = _textList[index].baseScaleFactor!;
    double orotate = _textList[index].rotation!;
    _textList[index].left = left + oLeft;
    _textList[index].top = top + oTop;
    _textList[index].scaleFactor = scale * obaseScaleFactor;

    if (orotate != (rotate + orotate)) {
      _textList[index].rotation = rotate + orotate;
    }

    notifyListeners();
  }

  void selectedText({required int index}) {
    _selectedTextIndex = index;
    notifyListeners();
  }

  void setBaseScaleFactor(
      {required double rotate,
      required double scaleFactor,
      required int index}) {
    _textList[index].baseScaleFactor = scaleFactor;
    _textList[index].rotation = rotate;
    notifyListeners();
  }

  void updateText(KfontStyleModel style, TextStyle textStyle, String title) {
    int index = textList.indexWhere((element) => element == style);
    if (title.isNotEmpty) {
      textList[index].textStyle = textStyle;
      textList[index].title = title;
    } else {
      textList.removeAt(index);
    }

    notifyListeners();
  }

  List<KfontStyleModel> get textList => _textList;
  int get selectedTextIndex => _selectedTextIndex;
}
