import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:pinput/pinput.dart';

class OTPInput extends StatelessWidget {
  OTPInput({super.key,required this.pinController});

  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)));

    final focusedPinTheme = defaultPinTheme.copyDecorationWith();
    final submittedPinTheme = defaultPinTheme.copyDecorationWith();
    String obscuringText = '●';

    return Container(
      height: 88,
      child: Pinput(
        controller: pinController,
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        errorPinTheme: submittedPinTheme,
        validator: (s) {
          return "";
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        pinAnimationType: PinAnimationType.slide,
        showCursor: true,
        obscuringCharacter: obscuringText,
        obscureText: true,
        // onCompleted: (pin) => print(pin),
      ),
    );
  }
}
