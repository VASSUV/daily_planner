
import 'package:dailyplanner/app/AppModel.dart';
import 'package:dailyplanner/other/WidgetsFactory.dart';
import 'package:dailyplanner/other/widget/LoaderWidget.dart';
import 'package:dailyplanner/page/main/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  var phone = "";
  var code = "";
  var isSendingCode = false;
  var loading = false;

  final phoneFieldState = GlobalKey<FormState>();
  final codeFieldState = GlobalKey<FormState>();

  String verificationId;


  final _mainRoute = MaterialPageRoute(builder: (context) => MainPage());
  void goToMain() => Navigator.of(context).pushReplacement(_mainRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
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
                  AbsorbPointer(
                    absorbing: isSendingCode,
                    child: _buildPhoneField(),
                  ),
                  isSendingCode ? _buildCodeField() : WidgetsFactory.space(),
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
              isSendingCode ? "Отправить код" : "Получить код",
              isSendingCode ? () => _tapToSendCode(context) : _tapToGetCode
          ),
        )
    );
  }

  Padding _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: WidgetsFactory.phoneInput(phoneFieldState, (value) {
        phone = value;
      }),
    );
  }

  Padding _buildCodeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: WidgetsFactory.codeInput(codeFieldState, (value) {
        code = value;
      }),
    );
  }

  void _tapToGetCode() async {
    validateFields(() async {
      setState(() => loading = true);
      await AppModel.I.authWithPhone(phone, _codeSent);
      setState(() => loading = false);
    });
  }

  void _tapToSendCode(BuildContext context) async {
    validateFields(() async {
      setState(() => loading = true);
      await AppModel.I.codeSent(phone, code, verificationId, (isSuccess) => _codeSentComplete(isSuccess, context));
      setState(() => loading = false);
    });
  }

  void _codeSent(String id, [code]){
    verificationId = id;
    setState(() => isSendingCode = true);
  }

  void _codeSentComplete(bool isSuccess, BuildContext context) {
    if(isSuccess) {
      goToMain();
    } else {
      final snackBar = SnackBar(content: Text("Попробуйте отправить код снова!"));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void validateFields(void continueGetCode()) {
    if(!phoneFieldState.currentState.validate()) return;
    phoneFieldState.currentState.save();
    continueGetCode();
  }

  void validateCodeField(void continueSendCode()) {
    if(!codeFieldState.currentState.validate()) return;
    codeFieldState.currentState.save();
    continueSendCode();
  }
}
