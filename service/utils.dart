import 'package:flutter/material.dart';

class Utils{

  static Future<void> displayDialog(BuildContext context, String text) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              title: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify
              ),
              content: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Dismiss'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white
                ),
              )
          );
        });
  }

  static Future<void> customDisplayDialog(BuildContext context, String text, String actionText, Function() function) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              title: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify
              ),
              content: ElevatedButton(
                onPressed: function,
                child: Text(actionText),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white
                ),
              )
          );
        });
  }

}