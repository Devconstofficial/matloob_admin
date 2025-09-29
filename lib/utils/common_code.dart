import 'package:easy_localization/easy_localization.dart' as lt;
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';

class CommonCode {
  static bool isValidEmail(String email) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    // print('=====================is email valid $emailValid');
    return emailValid;
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date.toLocal());
  }

  bool isValidPhone(String? inputString, {bool isRequired = false}) {
    bool isInputStringValid = false;

    if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
      isInputStringValid = true;
    }

    if (inputString != null && inputString.isNotEmpty) {
      if (inputString.length > 16 || inputString.length < 6) return false;

      const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }

  static unFocus(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static Future<void> logout() async {
    Get.offNamedUntil(kAuthScreenRoute, (predicate) => false);
    SessionManagement sessionManagement = SessionManagement();
    await sessionManagement.removeSession(
      token: SessionTokenKeys.kUserModelKey,
    );
    await sessionManagement.removeSession(
      token: SessionTokenKeys.kUserTokenKey,
    );
  }

  String t(String key) => lt.tr(key);
}
