import 'package:dailyplanner/app/AppModel.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  Color color = Colors.green;

  @override
  void initState() {
    super.initState();
    AppModel.I.authWithGoogle((isSuccess) {
       color = isSuccess ? Colors.blue : Colors.purple;
       setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: color);
  }
}
