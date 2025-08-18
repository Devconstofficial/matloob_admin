import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    brightness: brightness,
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    timePickerTheme: TimePickerThemeData(backgroundColor: kWhiteColor),
    datePickerTheme: DatePickerThemeData(backgroundColor: kWhiteColor),
    scaffoldBackgroundColor: kWhiteColor,
    appBarTheme: AppBarTheme(backgroundColor: kWhiteColor),
    colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor),
  );
}
