import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class StoreServices {
  StoreServices._();

  static final StoreServices _instance = StoreServices._();

  factory StoreServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<Map<String, dynamic>> getStores({
    String? q,
    String? status,
    int page = 1,
    int limit = 10,
    String sortField = "createdAt",
    String sortOrder = "desc",
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url =
        "${WebUrls.kGetAllStoresUrl}?q=${q ?? ''}&status=${status ?? ''}&page=$page&limit=$limit&sortField=$sortField&sortOrder=$sortOrder";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getStores==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final storesJson = responseModel.data["data"]["stores"] ?? [];
      final metaJson = responseModel.data["data"]["meta"] ?? {};

      List<Store> stores = List<Store>.from(
        storesJson.map((e) => Store.fromJson(e)),
      );

      return {"stores": stores, "meta": metaJson};
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch stores");
  }

  Future<Store> getStoreDetail(String storeId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kGetStoreDetailsUrl}/$storeId";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getStoreDetail==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final storeJson = responseModel.data["data"]["store"];
      return Store.fromJson(storeJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch store");
  }

  Future<Store> updateStore(
    String storeId,
    Map<String, dynamic> updateData,
  ) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kUpdateStoreUrl}/$storeId";

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: url,
      requestBody: updateData,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateStore==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final storeJson = responseModel.data["data"]["store"];
      return Store.fromJson(storeJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to update store");
  }

  Future<Store> updateStoreStatus(String storeId, String status) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kUpdateStoreStatusUrl}/$storeId";

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: url,
      requestBody: {"storeStatus": status},
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateStoreStatus==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final storeJson = responseModel.data["data"]["store"];
      return Store.fromJson(storeJson);
    }

    throw Exception(
      responseModel.data["message"] ?? "Failed to update store status",
    );
  }

  Future<String> deleteStore(String storeId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kDeleteStoreUrl}/$storeId";

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("deleteStore==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["message"] ?? "Store deleted successfully";
    }

    throw Exception(responseModel.data["message"] ?? "Failed to delete store");
  }

  Future<Store> addStore({
    required String userId,
    required String logo,
    required String companyName,
    required String companyNumber,
    required String location,
    required String speciality,
    String storeStatus = 'Accepted',
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = WebUrls.kAddStoreUrl;

    final requestBody = {
      "userId": userId,
      "logo": logo,
      "companyName": companyName,
      "companyNumber": companyNumber,
      "location": location,
      "speciality": speciality,
      "storeStatus": storeStatus,
    };

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: url,
      requestBody: requestBody,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("addStore==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final storeJson = responseModel.data["data"]["store"];
      return Store.fromJson(storeJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to create store");
  }
  
}
