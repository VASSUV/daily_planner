
import 'dart:async';
import 'package:dailyplanner/app/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

mixin FirebaseMixin {
  FirebaseApp _firebaseApp = FirebaseApp.instance;
  FirebaseAuth _auth;
  AuthResult _authResult;
  DatabaseReference _users;
}

mixin BaseMixin on FirebaseMixin {
  Future<void> initFirebase() async {
    _auth = FirebaseAuth.fromApp(_firebaseApp);
    _auth.signInAnonymously().then((value) => _authResult = value)
        .whenComplete(_authComplete)
        .catchError(_catchError);
  }
  
  void _authComplete() async {
    final database = FirebaseDatabase(app: _firebaseApp);
    database.setPersistenceEnabled(true);

    _users = database.reference().child("users");

    final user = await _users.child(_authResult.user.uid).once();
  }

  void _catchError(error) {
    print(error);
  }
}


mixin FireBaseAuthMixin on BaseMixin {
  void authWithGoogle(void complete(bool)) async {
    GoogleSignInAccount account;
    try {
      account = await GoogleSignIn.standard().signIn();
    } catch(error) {
      print(error);
    }
    if(account == null)  {
      complete(false);
      return;
    }
    var googleSignInAuthentication = await account.authentication;
    final credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );
    await _auth
        .signInWithCredential(credential)
        .then((value) => _authResult = value)
        .whenComplete(_authComplete)
        .catchError(_catchError);

    await _auth.verifyPhoneNumber(
        phoneNumber: "+79176181842",
        timeout: Duration(seconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);

    final user = await _users.child(_authResult.user.uid).once();
    if (user.value == null) {
      await _users.child(_authResult.user.uid).set((User()
        ..put("name", account.displayName)
        ..put("phone", account.email)
      ).toJson()).catchError(_catchError);
    }
    complete(true);
  }

  void _verificationCompleted(authCredential) {
    print(authCredential);
  }

  void _verificationFailed(authException) {
    print(authException);
  }

  void _codeSent(id, [code]) async {
    print(id);
    var user = await _auth.signInWithCredential(PhoneAuthProvider.getCredential(verificationId: id, smsCode: "123456"));
    print(user);
  }

  void _codeAutoRetrievalTimeout(id) {
    print(id);
  }
}