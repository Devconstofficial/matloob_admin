import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class RfqServices {
  RfqServices._();

  static final RfqServices _instance = RfqServices._();

  factory RfqServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<Map<String, dynamic>> getRFQs({
    String? q,
    String? status,
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
        "${WebUrls.kGetAllRFQSUrl}?q=${q ?? ''}&status=${status ?? ''}&startDate=${startDate ?? ''}&endDate=${endDate ?? ''}&page=$page&limit=$limit&sortField=$sortField&sortOrder=$sortOrder";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getRFQs==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final itemsJson = responseModel.data["data"]["items"] ?? [];
      final metaJson = responseModel.data["data"]["meta"] ?? {};

      List<RfqModel> rfqs =
          List<RfqModel>.from(itemsJson.map((e) => RfqModel.fromJson(e)));

      return {
        "items": rfqs,
        "meta": metaJson,
      };
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch RFQs");
  }

  Future<RfqModel> getRFQDetail(String rfqId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kGetRFQDetailsUrl}/$rfqId";

    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("getRFQDetail==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final rfqJson = responseModel.data["data"]["rfq"];
      return RfqModel.fromJson(rfqJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to fetch RFQ");
  }

  Future<RfqModel> updateRFQ(String rfqId, Map<String, dynamic> updateData) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kUpdateRFQUrl}/$rfqId";

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: url,
      requestBody: updateData,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateRFQ==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final rfqJson = responseModel.data["data"]["rfq"];
      return RfqModel.fromJson(rfqJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to update RFQ");
  }

  Future<RfqModel> updateRFQStatus(String rfqId, String status) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kUpdateRFQStatusUrl}/$rfqId/status";

    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: url,
      requestBody: {"status": status},
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("updateRFQStatus==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final rfqJson = responseModel.data["data"]["rfq"];
      return RfqModel.fromJson(rfqJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to update RFQ status");
  }
  
  Future<String> deleteRFQ(String rfqId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kDeleteRFQUrl}/$rfqId";

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("deleteRFQ==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["message"] ?? "RFQ deleted successfully";
    }

    throw Exception(responseModel.data["message"] ?? "Failed to delete RFQ");
  }
}
