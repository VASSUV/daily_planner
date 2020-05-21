import 'package:dailyplanner/page/launch/LaunchPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as EasyLocalize;
import 'AppModelWrapper.dart';


Future<void> main() async => runApp(AppModelWrapper());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: UniqueKey(),
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
