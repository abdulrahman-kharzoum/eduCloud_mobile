import 'package:flutter/material.dart';

class mapWidget extends StatelessWidget {
  const mapWidget({
    super.key,
    required this.screenHight,
    required this.bottom,
    required this.screenWidth,
  });

  final double screenHight;
  final double screenWidth;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHight / 2.5,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: const Image(
            image: AssetImage('assets/images/map.png'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: screenHight / 15,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image(
              image: const AssetImage('assets/images/buslogo.gif'),
              height: screenHight / 4,
            )),
        //this bottomn to show the location (follow now)
        Positioned(
            left: screenWidth / 25, bottom: screenHight / 15, child: bottom),
      ],
    );
  }
}
