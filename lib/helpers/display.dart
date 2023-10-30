import 'package:flutter/material.dart';

class DisplayTamano extends StatelessWidget {
  const DisplayTamano({super.key});

  @override
  Widget build(BuildContext context) {
    var width = displayWidth(context);
    var devicePixelRat = devicePixelRatio(context);
    var dHeigh = displayHeight(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          "pantalla Width $width devicePixelRatio  $devicePixelRat  displayHeight  $dHeigh"),
    );
  }
}

Size displaySize(BuildContext context) {
  // debug//print('Size = ${MediaQuery.of(context).size}');
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  // debug//print('Height = ${displaySize(context).height}');
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  // debug//print('Width = ${displaySize(context).width}');
  return displaySize(context).width;
}

double devicePixelRatio(BuildContext context) {
  // debug//print('Width = ${displaySize(context).width}');
  return displaySize(context).shortestSide;
}
