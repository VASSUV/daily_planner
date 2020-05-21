
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'mixin/FirebaseMixin.dart';

class AppModel with FirebaseMixin, BaseMixin, FireBaseAuthMixin {
  static String get _name => (AppModel).toString();

  get appLocale => Locale("ru");

  void _init() {
    Future.sync(() async {
//      Hive.init(path);
//      setPreferences(await SharedPreferences.getInstance());
      await initFirebase();
    });
  }

  AppModel._();

  factory AppModel() {
    if(!GetIt.I.isRegistered(instanceName: AppModel._name)) {
      final appModel = AppModel._();
      appModel._init();
      GetIt.I.registerSingleton(appModel, instanceName: AppModel._name);
      return appModel;
    }
    return GetIt.I.call(instanceName: _name);
  }

  static AppModel get I => AppModel();

  final updateState = PublishSubject();

  void dispose() {
    updateState.close();
  }
}
