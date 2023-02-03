import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBlock extends StatelessWidget {
  const ShimmerBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5,top: 5),
      child: Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.blue,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue)
            ),
          )
      ),
    );
  }
}