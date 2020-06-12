
import 'dart:ui';

import 'package:rxdart/rxdart.dart';

import 'mixin/FirebaseMixin.dart';

class AppModel with FirebaseMixin, BaseMixin, FireBaseAuthMixin, FirebaseSetUserDataMixin {
  static AppModel _instance;
  static AppModel get I => AppModel();

  final appLocaleState = BehaviorSubject<Locale>();

  AppModel._();

  factory AppModel() {
    if(_instance == null) {
      _instance = AppModel._();
      _instance._init();
      return _instance;
    }
    return _instance;
  }

  void _init() {
    Future.delayed(Duration(seconds: 0), () async {
      await initFirebase();
    });
    Future.delayed(Duration(seconds: 1), () {
      _instance.appLocaleState.add(Locale("ru"));
    });
  }
}
