import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'AppModel.dart';
import 'main.dart';

class AppModelWrapper extends StatefulWidget {
  @override
  _AppModelWrapperState createState() => _AppModelWrapperState();
}

class _AppModelWrapperState extends State<AppModelWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppModel.I.updateState.stream,
        builder: (context, snapshot) {
          return EasyLocalization(
            key: UniqueKey(),
            child: MyApp(),
            path: "langs",
            saveLocale: true,
            startLocale: AppModel.I.appLocale,
            supportedLocales: [
              Locale('en'),
              Locale('ru'),
              Locale('ar'),
            ],
          );
        }
    );
  }
}





