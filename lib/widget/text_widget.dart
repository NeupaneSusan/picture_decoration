import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_decoration/alert_page.dart';
import 'package:picture_decoration/model/touch_pont.dart';
import 'package:picture_decoration/view/title_page.dart';
import 'package:picture_decoration/viewmodel/brush_viewmodel.dart';
import 'package:picture_decoration/viewmodel/menu_viewmodel.dart';

import 'package:provider/provider.dart';

import 'package:picture_decoration/model/kfont_style_model.dart';
import 'package:picture_decoration/viewmodel/process_viewmodel.dart';
import 'dart:math';

class TextWidget extends StatelessWidget {
  final KfontStyleModel data;
  final int selectedIndex;
  final int index;
  const TextWidget(
      {super.key,
      required this.data,
      required this.selectedIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: data.left,
      top: data.top,
      child: GestureDetector(
        onTap: () {
          if (selectedIndex == index) {
            setTextToMove(context, -1);
            return;
          }
          setTextToMove(context, index);
          final provider = Provider.of<MenuController>(context, listen: false);
          provider.indexMenu = 5;
        },
        onDoubleTap: () {
          showDialogBox(
              context: context,
              child: TitlePage(
                data: data,
              ));
        },
        child: Transform.rotate(
          angle: (data.rotation!) / pi / 45,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                if (selectedIndex == index) ...[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white54, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.title,
                        textScaleFactor: data.scaleFactor,
                        style: data.textStyle,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: -10,
                    child: Icon(CupertinoIcons.multiply_circle_fill),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textScaleFactor: data.scaleFactor,
                      data.title,
                      style: data.textStyle,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void updatePositionText(ScaleUpdateDetails details, BuildContext context) {
  final provider = Provider.of<TextProcess>(context, listen: false);
  int index = provider.selectedTextIndex;
  double left = details.focalPointDelta.dx;
  double top = details.focalPointDelta.dy;
  double scale = details.scale;
  double rotate = details.rotation;
  if (index != -1) {
    provider.setPositionText(
        left: left, top: top, scale: scale, index: index, rotate: rotate);
  }
}

void setBaseScaleFactor(BuildContext context) {
  final provider = Provider.of<TextProcess>(context, listen: false);
  int index = provider.selectedTextIndex;
  if (index != -1) {
    provider.setBaseScaleFactor(
        rotate: provider.textList[index].rotation!,
        scaleFactor: provider.textList[index].scaleFactor!,
        index: index);
  }
}

void setTextToMove(BuildContext context, int index) {
  final provider = Provider.of<TextProcess>(context, listen: false);
  provider.selectedText(index: index);
}

void draw(BuildContext context, Offset offset) {
  final drawController = Provider.of<BrushController>(context, listen: false);
  TouchPoints p = TouchPoints(
      points: offset,
      paint: Paint()
        ..color = Colors.red
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true);
  drawController.setTouchPoint(p);
}
