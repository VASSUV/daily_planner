import 'package:dailyplanner/app/AppModel.dart';
import 'package:dailyplanner/other/widget/LoaderWidget.dart';
import 'package:dailyplanner/page/auth/AuthPage.dart';
import 'package:dailyplanner/page/main/MainPage.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with TickerProviderStateMixin {
  var phone = "";
  var loading = false;

  final _authRoute = MaterialPageRoute(builder: (context) => AuthPage());
  void goToAuth() => Navigator.of(context).pushReplacement(_authRoute);

  final _mainRoute = MaterialPageRoute(builder: (context) => MainPage());
  void goToMain() => Navigator.of(context).pushReplacement(_mainRoute);

  @override
  void initState() {
    super.initState();
    AppModel.I.onInitUser.listen((value) {
      value ? goToMain() : goToAuth();
      AppModel.I.onInitUser.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: buildContent(),
    );
  }

  Widget buildContent() => LoaderWidget();
}
