import 'package:flutter/material.dart';
import 'package:picture_decoration/view/home_page.dart';
import 'package:picture_decoration/viewmodel/brush_viewmodel.dart';
import 'package:picture_decoration/viewmodel/menu_viewmodel.dart';
import 'package:picture_decoration/viewmodel/process_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenusController(),
        ),
        ChangeNotifierProvider(create: (context) => BrushController()),
        ChangeNotifierProvider(
          create: (context) => TextProcess(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
