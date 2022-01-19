import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  List<Animation> curves;
  List<Animation<double>> animationSizes;
  Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    curves = [
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
      CurvedAnimation(parent: controller, curve: Curves.easeInToLinear),
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
      CurvedAnimation(parent: controller, curve: Curves.bounceIn),
      CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc),
      CurvedAnimation(parent: controller, curve: Curves.elasticOut)
    ];
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    animationSizes = List.generate(curves.length, (index) {
      var tempTween =
          Tween<double>(begin: 0, end: Random().nextInt(300).toDouble())
              .animate(curves[index])
            ..addListener(() {
              setState(() {});
            });
      return tempTween;
    });
    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          animationSizes.length,
          (index) {
            return Container(
              height: 50,
              margin: EdgeInsets.only(top: 40),
              width: animationSizes[index].value,
              color: colorAnimation.value,
            );
          },
        )
      ],
    ));
  }
}
