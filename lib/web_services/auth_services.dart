import 'dart:convert';
import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

import '../models/user_model.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kSignInUrl,
      requestBody: {"email": email, "password": password},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("loginUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userData = responseModel.data["data"]["user"];
      final authToken = responseModel.data["data"]["authToken"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserTokenKey,
        tokenValue: authToken,
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(userData),
      );
      return UserModel.fromJson(userData);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getUserFromSession() async {
    var result = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserModelKey,
    );
    log("getUserFromSession======>$result");
    if (result.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(result));
    }
  }

  Future<dynamic> requestPasswordReset({required String email}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kResetRequestUrl,
      requestBody: {"email": email},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("requestPasswordReset==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["data"];
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kVerifyOtpUrl,
      requestBody: {"email": email, "otp": otp},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("verifyResetOtp==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["data"];
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> resendResetOtp({required String email}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kResendOtpUrl,
      requestBody: {"email": email},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("resendResetOtp==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["data"];
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> setNewPassword({
    required String email,
    required String password,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kCreatePasswordUrl,
      requestBody: {"email": email, "password": password},
      requestHeader: {'Content-Type': 'application/json'},
    );

    log("setNewPassword==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["data"];
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
