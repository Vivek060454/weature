import 'package:flutter/material.dart';

class HorizontalWhiteLine extends StatelessWidget {
  const HorizontalWhiteLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Container(
          height: 1.5,
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 15.0),
        ),
      ),
    );
  }
}