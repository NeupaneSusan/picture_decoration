import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:picture_decoration/color.dart';
import 'package:picture_decoration/viewmodel/process_viewmodel.dart';

import '../model/kfont_style_model.dart';

class TitlePage extends StatefulWidget {
  final KfontStyleModel? data;
  const TitlePage({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  TextStyle textStyle = const TextStyle(
    fontSize: 30,
    color: Colors.white,
  );
  FocusNode focusNode = FocusNode();
  var textColor = colorList[1];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      textEditingController.text = widget.data!.title;
      textStyle = widget.data!.textStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Scaffold(
          backgroundColor: Colors.black54,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconButton(
                      icon: CupertinoIcons.multiply,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  iconButton(
                      icon: Icons.check,
                      onTap: () {
                        setTextStyle();
                        Navigator.of(context).pop();
                      })
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: TextFormField(
                      controller: textEditingController,
                      maxLength: 40,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: textStyle,
                      cursorColor: Colors.purple,
                      cursorHeight: 45,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Insert your message",
                          hintStyle:
                              TextStyle(fontSize: 34, color: Colors.white24)),
                      autofocus: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: colorList
                      .map((e) => GestureDetector(
                            onTap: (() {
                              setState(() {
                                textColor = e;
                                textStyle = TextStyle(
                                    fontSize: 30,
                                    color: textColor,
                                    letterSpacing: 1.5);
                              });
                            }),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: e == textColor ? Colors.white : e),
                                  color: e,
                                  boxShadow: kElevationToShadow[2]),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      //   ),
    );
  }

  Widget iconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.white,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  setTextStyle() {
    final imageProcessProvider =
        Provider.of<TextProcess>(context, listen: false);
    if (widget.data != null) {
      imageProcessProvider.updateText(
          widget.data!, textStyle, textEditingController.text);
      return;
    }
    final top = MediaQuery.of(context).size.height / 3.2;
    final left = MediaQuery.of(context).size.width / 2.1;

    imageProcessProvider.setText(
        title: textEditingController.text,
        textStyle: TextStyle(
          fontSize: 30,
          color: textColor,
          letterSpacing: 1.5,
        ),
        top: top,
        left: left);
  }
}
