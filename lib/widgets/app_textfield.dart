import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final VoidCallback? helpOnTap;
  final Widget? helpContent;
  final TextEditingController? controller;
  final bool? isObscureText;
  double? width;

  final inputFormatters;

  final textInputType;

  AppTextField({
    @required this.icon,
    @required this.hint,
    this.helpOnTap,
    this.helpContent,
    this.controller,
    this.isObscureText,
    this.width,
    this.inputFormatters = const <TextInputFormatter>[],
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          TextFormField(
            obscureText: isObscureText ?? false,
            inputFormatters: inputFormatters,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black38),
              prefixIcon: Icon(icon),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
              ),
            ),
            controller: controller,
          ),
          if (helpContent != null && helpOnTap != null)
            SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: helpOnTap,
                  child: helpContent,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  var max;

  CustomRangeTextInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return TextEditingValue();
    } else if (int.parse(newValue.text) < 0) {
      return TextEditingValue().copyWith(text: '0');
    }

    return int.parse(newValue.text) > max
        ? TextEditingValue().copyWith(text: max.toString())
        : newValue;
  }
}
