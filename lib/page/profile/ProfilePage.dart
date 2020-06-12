import 'package:dailyplanner/app/AppModel.dart';
import 'package:dailyplanner/other/WidgetsFactory.dart';
import 'package:dailyplanner/other/widget/LoaderWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var name = AppModel.I.user.value?.name ?? "";

  final nameFieldState = GlobalKey<FormState>();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          children: [
            _buildContent(),
            loading ? LoaderWidget() : WidgetsFactory.space()
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildNameField(),
//                  _buildEmailField(),
                ],
              ),
            ),
          ),
          _buildActionButton()
        ]
    );
  }

  SizedBox _buildActionButton() {
    return SizedBox(
        height: 52,
        child: Builder(
          builder: (BuildContext context) => WidgetsFactory.primaryButton(
              "Сохранить",
            _tapToSave
          ),
        )
    );
  }

  Padding _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: WidgetsFactory.nameInput(AppModel.I.user.value?.name, nameFieldState, (value) {
        name = value;
      }),
    );
  }

  void _tapToSave() async {
    validateFields(() async {
      setState(() => loading = true);

      final firebaseUser = AppModel.I.firebaseUser.value;
      await firebaseUser?.updateProfile(UserUpdateInfo()
        ..displayName = name
      );
      await firebaseUser.reload();

      await AppModel.I.setUserField("name", name);

      setState(() => loading = false);
      Navigator.pop(context);
    });
  }

  void validateFields(void continueSendCode()) {
    if(!nameFieldState.currentState.validate()) return;
    nameFieldState.currentState.save();
    continueSendCode();
  }
}
