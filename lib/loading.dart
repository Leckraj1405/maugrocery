import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Loading widget
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[700],
      child: Center(
        child: SpinKitFadingCircle(
          color: Color(0xFFFC6011),
          size: 150,
        ),
      ),
    );
  }
}
