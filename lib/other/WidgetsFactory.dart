import 'package:dailyplanner/other/resources/Images.dart';
import 'package:dailyplanner/other/resources/Styles.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart' as EasyLocalization;
import 'package:flutter/material.dart';
import 'StringExtensions.dart';
import 'package:flutter/services.dart';

class WidgetsFactory {
  static Expanded get expanded => Expanded(child: Opacity(opacity: 0));

  static Container space({double width = 0, double height = 0}) =>
      Container(height: height, width: width);

  static Widget sheetItemTile(String text, void onTap()) =>
      Material(
          color: Color(0xfff7f7f7),
          child: InkWell(
              onTap: onTap,
              child: ListTile(onTap: onTap, title: Center(
                  child: Text(text, textDirection: TextDirection.ltr,
                      style: text16(color: Colors.blue))
              ))
          )
      );

  static Widget sheetHeaderTile(String title) =>
      Container(height: 58, child: Stack(children: <Widget>[
        Center(child: Text(title, style: text16(color: Colors.black)))
      ]));

  static Widget blackButton(String text, void onTap()) =>
      Expanded(
          child: Container(color: Colors.black, child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onTap,
                  child: Center(child: Text(text, style: text12()))
              )
          ))
      );

  static Widget appBarButton(String text, void onTap()) =>
      MaterialButton(
        child: Center(child:
        Text(text, style: text16(color: Colors.green),)
        ),
        onPressed: onTap,
      );

  static Widget easyListTile(String text, void onTap()) =>
      Container(
        height: 56,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: ListTile(
              title: Text(text, style: text14(color: Colors.black)),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
        ),
      );

  static Widget primaryButton(String text, void onTap()) =>
      Material(
        color: Colors.green,
        child: InkWell(
            onTap: onTap,
            child: Center(child: Text(
                text,
                style: TextStyle(fontSize: 14)
            ))
        ),
      );

  static Widget secondaryButton(String text, void onTap()) =>
      Expanded(
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onTap,
                child: Center(
                    child: Text(text, style: text14(color: Colors.green)))
            )
        ),
      );

  static Widget passwordInput(void onChanged(String value)) {
    var valueListenable = ValueNotifier(true);
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (BuildContext context, bool value, Widget child) =>
              TextFormField(
                  onChanged: onChanged,
                  obscureText: value,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: "QnYh125!!".tr(),
                      labelText: "Password".tr(),
                      focusColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none),
                      suffixIcon: IconButton(
                          icon: Icon(
                              value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            valueListenable.value = !value;
                          },
                          color: Colors.grey
                      )
                  )
              )
      ),
    );
  }

  static Widget passwordRetypeInput(void onChanged(String value)) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: TextFormField(
            onChanged: onChanged,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: "QnYh125!!".tr(),
              labelText: "Retype Password".tr(),
              focusColor: Colors.grey,
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              errorBorder: UnderlineInputBorder(borderSide: BorderSide.none),
            )
        )
    );
  }

  static Widget phoneInput(
      GlobalKey<FormState> keyState,
      ValueChanged<String> onChanged
      ) {
    return Form(
      key: keyState,
      onChanged: (){
        keyState.currentState.save();
      },
      child: TextFormField(
        onChanged: onChanged,
        onSaved: (text) {
          if(text.onlyDigits.length == 10) {
            keyState.currentState.validate();
          }
        },
        decoration: InputDecoration(
            hintText: "(905) 000 00 00 ".tr(),
            icon: Icon(Icons.phone),
            prefixText: "+7 ".tr(),
            labelText: "Номер телефона *".tr(),
            filled: true,
            border: UnderlineInputBorder()
        ),
        validator: (value) {
          if(!(value.onlyDigits.length == 10) && value.isNotEmpty) {
            return "Заполните поле пожалуйста".tr();
          }
          if(value.isEmpty) {
            return "Поле не должно быть пустым".tr();
          }
          return null;
        },
        keyboardType: TextInputType.phone,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          PhoneInputValidator()
        ],
      ),
    );
  }


  static Widget nameInput(
      String value,
      GlobalKey<FormState> keyState,
      void onChanged(String value)
      ) {
    return Form(
        key: keyState,
        onChanged: () {
          keyState.currentState.save();
        },
        child: Container(
            child: TextFormField(
                initialValue: value,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: "Иванов Иван".tr(),
                  icon: Icon(Icons.title),
                  labelText: "Ваше имя *".tr(),
                  filled: true,
                  border: UnderlineInputBorder()
              ),
              validator: (value) {
                if (value.length <= 1) {
                  return "Поле не должно быть пустым".tr();
                }
                return null;
              },
              keyboardType: TextInputType.text,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r'.*')),
              ]
            )
        )
    );
  }

  static Widget emailInput(
      String value,
      GlobalKey<FormState> keyState,
      void onChanged(String value)
      ) {
    return Form(
        key: keyState,
        onChanged: () {
          keyState.currentState.save();
        },
        child: Container(
            child: TextFormField(
              initialValue: value,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: "ivanov.ivan@mail.ru".tr(),
                  icon: Icon(Icons.alternate_email),
                  labelText: "Ваш email".tr(),
                  filled: true,
                  border: UnderlineInputBorder()
              ),
              validator: (value) {
                if(value.length == 0) return null;
                if (!RegExp(r'.+@.+\..+').hasMatch(value)) {
                  return "Неверный адрес".tr();
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,

              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r'.*')),
              ]
            )
        )
    );
  }

  static Widget codeInput(
      GlobalKey<FormState> keyState,
      void onChanged(String value)
      ) {
    return Form(
        key: keyState,
        onChanged: () {
          keyState.currentState.save();
        },
        child: Container(
            child: TextFormField(
              autofocus: true,
              focusNode: FocusNode()
                ..requestFocus(),
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: "0000".tr(),
                  icon: Icon(Icons.check),
                  labelText: "Код подтверждения *".tr(),
                  filled: true,
                  border: UnderlineInputBorder()
              ),
              validator: (value) {
                if (value.length <= 1) {
                  return "Поле не должно быть пустым".tr();
                }
                return null;
              },
              keyboardType: TextInputType.text,

              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(r'\w+')),
              ],
            )
        )
    );
  }

  static Widget get questionIcon =>
      ClipOval(
        child: Container(
          width: 22,
          height: 22,
          color: Colors.white10,
          child: Center(child: Text("?")),
        ),
      );
}

class PhoneInputValidator extends TextInputFormatter {
  final _mask = "(###) ###-##-##";
  final _escapeChar = '#';


  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = StringBuffer();
    var maskSymbol = _mask[0];
    var charIndex = -1;
    var finalSelectionIndex = -1;
    var isSelection = false;
    final isBack = oldValue.text.onlyDigits == newValue.text;
    if(newValue.text.length == 0) return newValue;

    for(int i = 0; i < _mask.length; i++) {
      maskSymbol = _mask[i];

      if(!isBack && isSelection == true && finalSelectionIndex != i) {
        finalSelectionIndex = i;
      }

      if(maskSymbol == _escapeChar) {
        isSelection = false;
        var number;
        do {
          charIndex++;
          if(charIndex == newValue.text.length) break;

          number = charIndex >= newValue.text.length ? null : int.tryParse(newValue.text[charIndex]);
          if(newValue.selection.end - 1 == charIndex) {
            finalSelectionIndex = i + 1;
            isSelection = true;
          }
        } while(number == null);

        if(charIndex == newValue.text.length) break;
        newText.write(number);
      } else {
        newText.write(maskSymbol);
      }
    }
    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: finalSelectionIndex == -1 ? newText.length : finalSelectionIndex)
    );
  }
}