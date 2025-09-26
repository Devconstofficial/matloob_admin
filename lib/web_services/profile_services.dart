import 'dart:convert';
import 'dart:developer';

import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/user_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class ProfileServices {
  ProfileServices._();

  static final ProfileServices _instance = ProfileServices._();

  factory ProfileServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> getMyProfile() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetProfileUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getMyProfile==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userData = responseModel.data["data"]["user"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(userData),
      );
      return UserModel.fromJson(userData);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> updateProfile({
    String? email,
    String? name,
    String? profileImage,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    Map<String, dynamic> updateData = {};
    if (email != null) updateData["email"] = email;
    if (name != null) updateData["name"] = name;
    if (profileImage != null) updateData["profileImage"] = profileImage;

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: WebUrls.kUpdateProfileUrl,
      requestBody: updateData,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateProfile==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userData = responseModel.data["data"]["user"];
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(userData),
      );
      return UserModel.fromJson(userData);
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
