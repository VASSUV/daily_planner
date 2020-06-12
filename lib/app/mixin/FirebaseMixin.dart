
import 'dart:async';
import 'package:dailyplanner/app/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dailyplanner/other/StringExtensions.dart';
import 'package:rxdart/rxdart.dart';

mixin FirebaseMixin {
  FirebaseApp _firebaseApp = FirebaseApp.instance;
  DatabaseReference _databaseReference;
  FirebaseAuth _auth;

  final firebaseUser = BehaviorSubject<FirebaseUser>();
  final user = BehaviorSubject<User>();
  final onInitUser = BehaviorSubject<bool>();
}

mixin BaseMixin on FirebaseMixin {

  DatabaseReference get _users => _databaseReference.child("users");
  DatabaseReference get userReference => _users.child(firebaseUser.value?.uid);

  Future<void> initFirebase() async {
    _auth = FirebaseAuth.fromApp(_firebaseApp);

    var currentUser = await _auth.currentUser();
    currentUser ??= (await _auth.signInAnonymously().catchError(_catchError)).user;

    if(currentUser?.isAnonymous != true) {
      firebaseUser.add(currentUser);
      await _authComplete();
      userReference.onChildChanged
          .map((e) async => await userReference.once())
          .listen((event) async {
            var snapshot = await userReference.once();
            user.add(User(data: snapshot.value));
          });
    }
    onInitUser.add(currentUser?.isAnonymous != true);
  }
  
  Future<void> _authComplete() async {
    final database = FirebaseDatabase(app: _firebaseApp);
    database.setPersistenceEnabled(true);
    _databaseReference = database.reference();
    final snapshot = await userReference.once();
    user.add(User(data: snapshot.value));
  }

  void _catchError(error) => print(error);
}

mixin FirebaseSetUserDataMixin on BaseMixin {
  Future<void> setUserField(String fieldName, String value) {
    var user = _users.child(this.firebaseUser.value.uid);
    return user.child(fieldName).set(value);
  }
}

mixin FireBaseAuthMixin on BaseMixin {
  Future<void> authWithPhone(String phone, void codeSent(String id, [code])) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '+7${phone.onlyDigits}',
        timeout: Duration(seconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  Future<void> codeSent(String phone, String code, String verificationId, void onComplete(bool isSuccess)) async {
    final credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
    AuthResult _authResult;
    try {
      _authResult = await _auth.signInWithCredential(credential);
    } catch(error) {
      onComplete(false);
      return;
    }

    this.firebaseUser.add(_authResult.user);

    onComplete(true);
  }


  void _verificationCompleted(authCredential) => print(authCredential);
  void _verificationFailed(authException) => print(authException);
  void _codeAutoRetrievalTimeout(id) => print(id);
}