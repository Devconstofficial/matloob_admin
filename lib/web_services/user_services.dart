import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/user_analytics_model.dart';
import 'package:matloob_admin/models/user_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class UserServices {
  UserServices._();

  static final UserServices _instance = UserServices._();

  factory UserServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<List<UserModel>> getAllUsers({
    String? query,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url =
        "${WebUrls.kGetAllUsersUrl}?q=${query ?? ''}&status=${status ?? ''}&page=$page&limit=$limit";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getAllUsers==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<dynamic> usersJson = responseModel.data["data"]["users"];
      return usersJson.map((e) => UserModel.fromJson(e)).toList();
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch users");
  }

  Future<UserModel> updateUserStatus({
    required String userId,
    required String status,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kUpdateUserStatusUrl}/$userId";

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: url,
      requestBody: {"status": status},
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateUserStatus==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userJson = responseModel.data["data"]["user"];
      return UserModel.fromJson(userJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to update user");
  }

  Future<String> deleteUser(String userId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kDeleteUserUrl}/$userId";

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("deleteUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["message"] ?? "User deleted successfully";
    }

    throw Exception(responseModel.data["message"] ?? "Failed to delete user");
  }

  Future<List<UserWithAnalytics>> getUsersWithAnalytics() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = WebUrls.kGetAllUsersAnalyticsUrl;

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getUsersWithAnalytics==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<dynamic> usersJson = responseModel.data["data"]["items"] ?? [];

      return usersJson.map((e) => UserWithAnalytics.fromJson(e)).toList();
    }

    throw Exception(
      responseModel.data["message"] ?? "Failed to fetch users with analytics",
    );
  }

  Future<UserModel> updateUser({
    required String userId,
    String? name,
    String? mobile,
    String? email,
    String? companyName,
    String? status,
    String? roles,
    bool? isVerified,
    String? profileImage,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: "${WebUrls.kUpdateUserUrl}/$userId",
      requestBody: {
        if (name != null) "name": name,
        if (mobile != null) "mobile": mobile,
        if (email != null) "email": email,
        if (companyName != null) "companyName": companyName,
        if (status != null) "status": status,
        if (roles != null) "roles": roles,
        if (isVerified != null) "isVerified": isVerified,
        if (profileImage != null) "profileImage": profileImage,
      },
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userJson = responseModel.data["data"]["user"];
      return UserModel.fromJson(userJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to update user");
  }

  Future<UserModel> addUser({
    required String name,
    required String mobile,
    String? email,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kAddUserUrl,
      requestBody: {
        "name": name,
        "mobile": mobile,
        if (email != null) "email": email,
      },
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("addUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final userJson = responseModel.data["data"]["user"];
      return UserModel.fromJson(userJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to create user");
  }

  Future<List<Map<String, dynamic>>> getUsersBasic() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetUsersBasicUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getUsersBasic==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<dynamic> usersJson = responseModel.data["data"]["users"];
      return usersJson.map((e) => e as Map<String, dynamic>).toList();
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch users");
  }
}
