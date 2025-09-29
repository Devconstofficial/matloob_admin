import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/custom_widgets/custom_snackbar.dart';
import 'package:matloob_admin/models/user_model.dart';
import 'package:matloob_admin/utils/app_colors.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/web_services/auth_services.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  var isLoadingLogin = false.obs;
  var isLoadingForgot = false.obs;
  var isLoadingResent = false.obs;
  var isLoadingVerify = false.obs;
  var isLoadingCreatePassword = false.obs;
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var forgetEmailCont = TextEditingController();
  var passwordforgotCont = TextEditingController();
  var passwordforgotConfirmCont = TextEditingController();
  var code = "".obs;
  Future<void> loginUser() async {
    final email = emailCont.text.trim();
    final password = passwordCont.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showCustomSnackbar("Error", "All fields are required");
      return;
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(email)) {
      showCustomSnackbar("Error", "Please enter a valid email address");
      return;
    }

    try {
      isLoadingLogin.value = true;

      var result = await authService.loginUser(
        email: email,
        password: password,
      );

      if (result is UserModel) {
        Get.toNamed(kDashboardScreenRoute);
        showCustomSnackbar(
          "Success",
          "You're logged in successfully!",
          backgroundColor: kGreenColor,
        );
      } else {
        showCustomSnackbar("Error", result.toString());
      }
    } catch (e, st) {
      log("Login error: $e $st");
      showCustomSnackbar("Error", "Something went wrong, please try again");
    } finally {
      isLoadingLogin.value = false;
    }
  }

  Future<void> requestPasswordReset() async {
    final email = forgetEmailCont.text.trim();
    if (email.isEmpty) {
      showCustomSnackbar("Error", "Please enter your email");
      return;
    }
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!emailRegex.hasMatch(email)) {
      showCustomSnackbar("Error", "Please enter a valid email address");
      return;
    }

    try {
      isLoadingForgot.value = true;
      var result = await authService.requestPasswordReset(email: email);

      if (result is String) {
        showCustomSnackbar("Error", result);
      } else {
        showCustomSnackbar(
          "Success",
          "OTP sent to your email: $email",
          backgroundColor: kGreenColor,
        );
        Get.toNamed(kVerifyOtpScreenRoute);
      }
    } catch (e) {
      log("requestPasswordReset error: $e");
      showCustomSnackbar("Error", "Something went wrong, try again");
    } finally {
      isLoadingForgot.value = false;
    }
  }

  Future<void> verifyOtp() async {
    final email = forgetEmailCont.text.trim();
    final otpCode = code.value.trim();

    if (otpCode.isEmpty || otpCode.length != 4) {
      showCustomSnackbar("Error", "Please enter a valid OTP");
      return;
    }
    try {
      isLoadingVerify.value = true;
      var result = await authService.verifyResetOtp(email: email, otp: otpCode);
      if (result is String) {
        showCustomSnackbar("Error", result.toString());
      } else {
        showCustomSnackbar(
          "Success",
          "OTP verified. Set your new password",
          backgroundColor: kGreenColor,
        );
        Get.toNamed(kSetNewPassScreenRoute);
      }
    } catch (e) {
      log("verifyOtp error: $e");
      showCustomSnackbar("Error", "Something went wrong, try again");
    } finally {
      isLoadingVerify.value = false;
    }
  }

  Future<void> resendOtp() async {
    final email = forgetEmailCont.text.trim();
    if (email.isEmpty) {
      showCustomSnackbar("Error", "Email required");
      return;
    }
    try {
      isLoadingResent.value = true;
      var result = await authService.resendResetOtp(email: email);
      if (result is String) {
        showCustomSnackbar("Error", result.toString());
      } else {
        showCustomSnackbar(
          "Success",
          "OTP resent to $email",
          backgroundColor: kGreenColor,
        );
      }
    } catch (e) {
      log("resendOtp error: $e");
      showCustomSnackbar("Error", "Something went wrong");
    } finally {
      isLoadingResent.value = false;
    }
  }

  Future<void> setNewPassword(VoidCallback onSuccess) async {
    final email = forgetEmailCont.text.trim();
    final password = passwordforgotCont.text.trim();
    final confirm = passwordforgotConfirmCont.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      showCustomSnackbar("Error", "All fields are required");
      return;
    }
    if (password != confirm) {
      showCustomSnackbar("Error", "Passwords do not match");
      return;
    }

    try {
      isLoadingCreatePassword.value = true;
      var result = await authService.setNewPassword(
        email: email,
        password: password,
      );
      if (result is String) {
        showCustomSnackbar("Error", result.toString());
      } else {
        onSuccess();
      }
    } catch (e) {
      log("setNewPassword error: $e");
      showCustomSnackbar("Error", "Something went wrong, try again");
    } finally {
      isLoadingCreatePassword.value = false;
    }
  }

  var isPasswordHidden = true.obs;
  var isPasswordHidden1 = true.obs;
  var isPasswordHidden2 = true.obs;
  RxBool isNotificationsOn = false.obs;
  var selectedTab = 0.obs;

  var selectedChips = <String>[].obs;

  void toggleChip(String label) {
    if (selectedChips.contains(label)) {
      selectedChips.remove(label);
    } else {
      selectedChips.add(label);
    }
  }

  List<List<String>> medicalProd = [
    [
      "Medical consumables",
      "Dental clinics",
      "Dental laboratories",
      "Dermatology and cosmetics",
      "Laboratories and Analysis",
    ],
    [
      "Dental chairs and accessories",
      "Equipment, devices and photography",
      "Anesthesia",
      "Dental Burs",
      "Sterilization & Disinfection",
    ],
  ];

  List<List<String>> medServices = [
    [
      "Medical consumables",
      "Dental clinics",
      "Dental laboratories",
      "Dermatology and cosmetics",
      "Laboratories and Analysis",
    ],
    [
      "Dental chairs and accessories",
      "Equipment, devices and photography",
      "Anesthesia",
      "Dental Burs",
      "Sterilization & Disinfection",
    ],
  ];

  List<List<String>> labEqu = [
    [
      "Medical consumables",
      "Dental clinics",
      "Dental laboratories",
      "Dermatology and cosmetics",
      "Laboratories and Analysis",
    ],
    [
      "Dental chairs and accessories",
      "Equipment, devices and photography",
      "Anesthesia",
      "Dental Burs",
      "Sterilization & Disinfection",
    ],
  ];

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void togglePasswordVisibility1() {
    isPasswordHidden1.value = !isPasswordHidden1.value;
  }

  void togglePasswordVisibility2() {
    isPasswordHidden2.value = !isPasswordHidden2.value;
  }
}
