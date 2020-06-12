import 'package:dailyplanner/app/AppModel.dart';
import 'package:dailyplanner/app/model/User.dart';
import 'package:dailyplanner/other/WidgetsFactory.dart';
import 'package:dailyplanner/page/profile/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CupertinoPageRoute get _profileRoute => CupertinoPageRoute(builder: (context) => ProfilePage());
  void _goToProfile() => Navigator.of(context).push(_profileRoute);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: AppModel.I.user,
                initialData: AppModel.I.user.value,
                builder: (context, data) {
                  var text = (data.data as User)?.toJson()?.toString() ?? "";
                  return Text(text);
                },
              ),
            ),
          ),
          WidgetsFactory.primaryButton("Профиль",  _goToProfile)
        ],
      ),
    );
  }
}
