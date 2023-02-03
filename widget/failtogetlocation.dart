import 'package:flutter/material.dart';

class FaliedToGetLocationWidget extends StatelessWidget {
  const FaliedToGetLocationWidget({Key? key, required this.onPressed}) : super(key: key);

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 60,
                width: 60,
                child: Image.asset("images/cloud.png"),
              ),
              Text("Failed to get your location,\n Please enable your location services", textAlign: TextAlign.center),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: onPressed,
                    child: Text("Enable")
                ),
              )
            ]
        )
    );
  }
}