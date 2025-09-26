import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/store_click_model.dart';
import 'package:matloob_admin/models/rfq_click_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class ClickServices {
  ClickServices._();

  static final ClickServices _instance = ClickServices._();

  factory ClickServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();


  Future<List<RFQClick>> getRFQClicks({
    String? query,
    String? action,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
    String sortField = "createdAt",
    String sortOrder = "desc",
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url =
        "${WebUrls.kGetRFQClickUrl}?q=${query ?? ''}&action=${action ?? ''}&startDate=${startDate ?? ''}&endDate=${endDate ?? ''}&page=$page&limit=$limit&sortField=$sortField&sortOrder=$sortOrder";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getRFQClicks =================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<dynamic> itemsJson = responseModel.data["data"]["items"];
      return itemsJson.map((e) => RFQClick.fromJson(e)).toList();
    }

    throw Exception(
        responseModel.data["message"] ?? "Failed to fetch RFQ clicks");
  }

  Future<List<StoreClick>> getStoreClicks({
    String? query,
    String? action,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 10,
    String sortField = "createdAt",
    String sortOrder = "desc",
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url =
        "${WebUrls.kGetStoreClickUrl}?q=${query ?? ''}&action=${action ?? ''}&startDate=${startDate ?? ''}&endDate=${endDate ?? ''}&page=$page&limit=$limit&sortField=$sortField&sortOrder=$sortOrder";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getStoreClicks =================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<dynamic> itemsJson = responseModel.data["data"]["items"];
      return itemsJson.map((e) => StoreClick.fromJson(e)).toList();
    }

    throw Exception(
        responseModel.data["message"] ?? "Failed to fetch Store clicks");
  }
}
