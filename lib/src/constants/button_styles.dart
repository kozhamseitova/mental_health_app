import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';

ButtonStyle buttonStyle = ButtonStyle(
  minimumSize: MaterialStateProperty.all(const Size(275, 60)),
  backgroundColor: MaterialStateProperty.all(cButtonColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);