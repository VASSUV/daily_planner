import 'package:dailyplanner/other/resources/Images.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> with SingleTickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return RotationTransition(
      turns: _animationController,
      child: Center(
        child: Container(
            child: Images.preloader,
            width: 64,
            height: 64
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}