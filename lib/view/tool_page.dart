import 'package:flutter/material.dart';

import 'package:picture_decoration/color.dart';
import 'package:picture_decoration/view/menu_button.dart';
import 'package:picture_decoration/view/title_page.dart';
import 'package:picture_decoration/viewmodel/brush_viewmodel.dart';
import 'package:picture_decoration/viewmodel/menu_viewmodel.dart';
import 'package:picture_decoration/widget/testing.dart';
import 'package:provider/provider.dart';

import '../alert_page.dart';

class Tools extends StatefulWidget {
  const Tools({
    Key? key,
  }) : super(key: key);

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  double _value = 0;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Slider(
              min: 0,
              max: 100,
              activeColor: Colors.purple,
              inactiveColor: Colors.purpleAccent,
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: colorList
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5, color: e),
                                boxShadow: kElevationToShadow[2],
                                color: e,
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ))
                    .toList()),
            const Spacer(),
            FittedBox(
              fit: BoxFit.cover,
              child: Consumer<MenuController>(builder: (context, data, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuBotton(
                      notifyListeners: data,
                      index: 0,
                      iconData: Icons.undo,
                      lebel: 'Undo',
                      onTap: () {
                       Provider.of<BrushController>(context,listen: false).undo();
                      },
                    ),
                    MenuBotton(
                      notifyListeners: data,
                      index: 1,
                      iconData: Icons.cut,
                      lebel: 'Magic Cut',
                      onTap: () {
                        
                      },
                    ),
                    MenuBotton(
                      notifyListeners: data,
                      index: 2,
                      iconData: Icons.directions,
                      lebel: 'Move',
                      onTap: () {

                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Testing()));
                      },
                    ),
                    MenuBotton(
                      notifyListeners: data,
                      index: 3,
                      iconData: Icons.directions,
                      lebel: 'Eraser',
                      onTap: () {
                        data.indexMenu =3;
                      },
                    ),
                    MenuBotton(
                      notifyListeners: data,
                      index: 4,
                      iconData: Icons.brush,
                      lebel: 'Brush',
                      onTap: () {
                        data.indexMenu = 4;
                      },
                    ),
                    MenuBotton(
                      notifyListeners: data,
                      index: 5,
                      iconData: Icons.abc,
                      lebel: 'Text',
                      onTap: () {
                        data.indexMenu = 5;
                        showDialogBox(
                            context: context, child: const TitlePage());
                      },
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
