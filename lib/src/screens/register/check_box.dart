import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';

class CheckBoxR extends StatefulWidget {
  const CheckBoxR({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final Function(bool) callback;

  @override
  State<CheckBoxR> createState() => _CheckBox();
}

class _CheckBox extends State<CheckBoxR> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (isChecked) {
        return primary;
      }
      return Colors.grey;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onChanged: (bool? value) {
        setState(() {
          widget.callback(value!);
          isChecked = value;
        });
      },
    );
  }
}
