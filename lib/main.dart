import 'package:dailyplanner/page/launch/LaunchPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as EasyLocalize;
import 'app/AppModelWrapper.dart';


Future<void> main() async => runApp(AppModelWrapper());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: EasyLocalize.EasyLocalization
          .of(context)
          .locale,
      localizationsDelegates: EasyLocalize.EasyLocalization
          .of(context)
          .delegates,
      supportedLocales: EasyLocalize.EasyLocalization
          .of(context)
          .supportedLocales,
      debugShowCheckedModeBanner: true,

      theme: ThemeData(
          brightness: Brightness.dark
      ),
      title: 'App name'.tr(),
      home: LaunchPage(),
    );
  }
}
