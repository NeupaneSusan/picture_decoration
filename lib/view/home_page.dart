import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:picture_decoration/color.dart';

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
  ValueNotifier<String?> valueNotifierImage = ValueNotifier(null);

  ValueNotifier<Color> colorSelectedValueNotifier = ValueNotifier(colorList[3]);
  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 10);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    final file = File('/storage/emulated/0/Download/test1.png');
    await file.writeAsBytes(pngBytes);
  }

  _uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      valueNotifierImage.value = (result.files[0].path);
    }
  }

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _uploadImage();
                      },
                      child: const Text('Upload Image')),
                  TextButton(
                      onPressed: () {
                        _capturePng();
                      },
                      child: const Text('Save')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ClipRRect(
                  child: Consumer<MenusController>(
                      builder: (context, controller, child) {
                    return controller.indexMenu == 4 ||
                            controller.indexMenu == 3
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onPanStart: (details) {
                                final brushController =
                                    Provider.of<BrushController>(context,
                                        listen: false);
                                RenderBox renderBox =
                                    context.findRenderObject()! as RenderBox;
                                if (controller.indexMenu == 4) {
                                  draw(
                                      context,
                                      renderBox.globalToLocal(
                                          details.globalPosition),
                                      brushController.widthStock,
                                      colorSelectedValueNotifier.value);
                                } else if (controller.indexMenu == 3) {
                                  eraser(
                                    context,
                                    renderBox
                                        .globalToLocal(details.globalPosition),
                                    brushController.widthStock,
                                  );
                                }
                              },
                              onPanUpdate: (details) {
                                RenderBox renderBox =
                                    context.findRenderObject()! as RenderBox;
                                final brushController =
                                    Provider.of<BrushController>(context,
                                        listen: false);
                                if (controller.indexMenu == 4) {
                                  draw(
                                      context,
                                      renderBox.globalToLocal(
                                          details.globalPosition),
                                      brushController.widthStock,
                                      colorSelectedValueNotifier.value);
                                } else if (controller.indexMenu == 3) {
                                  eraser(
                                    context,
                                    renderBox
                                        .globalToLocal(details.globalPosition),
                                    brushController.widthStock,
                                  );
                                }
                              },
                              onPanEnd: (details) {
                                final provider = Provider.of<BrushController>(
                                    context,
                                    listen: false);
                                if (controller.indexMenu == 4) {
                                  provider.setTouchPoint(null);
                                } else if (controller.indexMenu == 3) {
                                  provider.setEraseTouchPoint(null);
                                }
                              },
                              child: ValueListenableBuilder(
                                  valueListenable: valueNotifierImage,
                                  builder: (context, imagePath, child) {
                                    return StackPage(
                                      imagePath: imagePath,
                                      height: height,
                                      globalKey: globalKey,
                                    );
                                  }),
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
                            child: ValueListenableBuilder(
                                valueListenable: valueNotifierImage,
                                builder: (context, imagePath, child) {
                                  return StackPage(
                                    imagePath: imagePath,
                                    height: height,
                                    globalKey: globalKey,
                                  );
                                }),
                          );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Tools(
                  colorValueNotifier: colorSelectedValueNotifier,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StackPage extends StatelessWidget {
  final String? imagePath;
  final double height;
  final GlobalKey globalKey;
  const StackPage(
      {super.key,
      required this.height,
      required this.globalKey,
      required this.imagePath});

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
                child: imagePath != null
                    ? Image.file(File(imagePath!))
                    : Image.asset(
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
