import 'package:flutter/material.dart';
import 'package:picture_decoration/viewmodel/menu_viewmodel.dart';
import 'package:picture_decoration/viewmodel/process_viewmodel.dart';
import 'package:provider/provider.dart';

class MenuBotton extends StatelessWidget {
  final MenusController notifyListeners;
  final int index;
  final IconData iconData;
  final String lebel;
  final VoidCallback onTap;
  const MenuBotton(
      {super.key,
      required this.iconData,
      required this.lebel,
      required this.onTap,
      required this.notifyListeners,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.yellow,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (() {
          if (index != 5) {
            final textProcess =
                Provider.of<TextProcess>(context, listen: false);
            textProcess.selectedText(index: -1);
          }
          onTap();
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.only(right: 1),
          width: MediaQuery.of(context).size.width / 6,
          decoration: notifyListeners.indexMenu == index
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.yellow)
              : null,
          child: Column(
            children: [
              Icon(
                iconData,
                size: 26,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(lebel),
            ],
          ),
        ),
      ),
    );
  }
}
