import 'package:dailyplanner/other/widget/LoaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'AppModel.dart';
import '../main.dart';


class AppModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppModel.I.appLocaleState.stream,
        builder: (context, snapshot) {
          Locale locale = snapshot?.data;

          if(locale == null) return LoaderWidget();

          return EasyLocalization(
            key: ValueKey(locale.languageCode),
            child: MyApp(),
            path: "langs",
            saveLocale: true,
            startLocale: locale,
            supportedLocales: [
              Locale('en'),
              Locale('ru')
            ],
          );
        }
    );
  }
}





