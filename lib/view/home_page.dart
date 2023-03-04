import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picture_decoration/view/tool_page.dart';
import 'package:picture_decoration/viewmodel/brush_viewmodel.dart';
import 'package:picture_decoration/viewmodel/menu_viewmodel.dart';
import 'package:picture_decoration/viewmodel/process_viewmodel.dart';
import 'package:picture_decoration/widget/mypainter.dart';
import 'package:picture_decoration/widget/text_widget.dart';
import 'package:provider/provider.dart';

import 'dart:ui' as ui;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 10);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    final file = File('/storage/emulated/0/Download/test1.png');
    await file.writeAsBytes(pngBytes);
  }

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _capturePng();
                },
                child: Text('Save')),
            Expanded(
              child: Consumer<MenuController>(
                  builder: (context, controller, child) {
                return controller.indexMenu == 4
                    ? GestureDetector(
                        onPanStart: (details) {
                         RenderBox renderBox = context.findRenderObject()! as RenderBox;
                         
                          draw(context, renderBox.globalToLocal(details.globalPosition),);
                        },
                        onPanUpdate: (details) {
                             RenderBox renderBox = context.findRenderObject()! as RenderBox;
                          draw(context, renderBox.globalToLocal(details.globalPosition),);
                        },
                        onPanEnd: (details) {
                          final provider = Provider.of<BrushController>(context,
                              listen: false);
                          provider.setTouchPoint(null);
                        },
                        child: StackPage(
                          height: height,
                          globalKey: globalKey,
                        ),
                      )
                    : GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setTextToMove(context, -1);
                        },
                        onScaleStart: (details) {
                          setBaseScaleFactor(context);
                        },
                        onScaleUpdate: (details) {
                          updatePositionText(details, context);
                        },
                        onScaleEnd: (details) {},
                        child: StackPage(
                          height: height,
                          globalKey: globalKey,
                        ),
                      );
              }),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Tools(),
            )
          ],
        ),
      ),
    );
  }
}

class StackPage extends StatelessWidget {
  final double height;
  final GlobalKey globalKey;
  const StackPage({super.key, required this.height, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: double.maxFinite,
          child: Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        RepaintBoundary(
          key: globalKey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Image.asset(
                  'assets/1.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              Consumer<BrushController>(
                  builder: (context, brushController, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: MyPainter(
                    pointsList: brushController.touchPoints,
                  ),
                );
              }),
              Consumer<TextProcess>(
                builder: (context, provider, child) {
                  int index = -1;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ...provider.textList.map((e) {
                        index += 1;
                        return TextWidget(
                          data: e,
                          selectedIndex: provider.selectedTextIndex,
                          index: index,
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
