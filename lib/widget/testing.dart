import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// class Testing extends StatefulWidget {
//   @override
//   _TestingState createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   double top = 300; // distance to top
//   double left = 150; // distance to left
//   double scale = 1;
//   double angle = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: RawGestureDetector(
//         gestures: {
         
//           ImmediateMultiDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<ImmediateMultiDragGestureRecognizer>(
//             () => ImmediateMultiDragGestureRecognizer(),
//             (recognizer) {
//               print(recognizer);
//               recognizer
//                 ..onStart = ( details) {
//                  print(details);
                
//                 };
                
               
//             },
//           ),
//         },
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Container(),
//             Positioned(
//               left: left,
//               top: top,
//               child: Transform.rotate(
//                 angle: angle * pi / 45,
//                 child: Transform.scale(
//                   scale: scale,
//                   child: GestureDetector(
//                       child: Container(
//                           height: 100, width: 100, child: FlutterLogo())),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class PayMethod extends StatefulWidget {
  const PayMethod({super.key});

  @override
  State<PayMethod> createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: []),
    );
  }
}