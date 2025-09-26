import 'dart:developer';
import 'package:matloob_admin/models/response_model.dart';
import 'package:matloob_admin/models/medical_product_model.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';
import 'package:matloob_admin/web_services/http_request.dart';
import 'package:matloob_admin/web_services/web_urls.dart';

class MedicalProductsServices {
  MedicalProductsServices._();

  static final MedicalProductsServices _instance = MedicalProductsServices._();

  factory MedicalProductsServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<MedicalProducts> createProduct({
    required String storeId,
    String? brand,
    String? category,
    String? subCategory,
    required String title,
    required String country,
    bool isContactForPrice = false,
    List<String> images = const [],
    String? description,
    double price = 0,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = WebUrls.kCreateProductUrl;

    final requestBody = {
      "storeId": storeId,
      "brand": brand,
      "category": category,
      "subCategory": subCategory,
      "title": title,
      "country": country,
      "isContactForPrice": isContactForPrice,
      "images": images,
      "description": description,
      "price": price,
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

    log("createProduct==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final productJson = responseModel.data["data"]["product"];
      return MedicalProducts.fromJson(productJson);
    }

    throw Exception(responseModel.data["message"] ?? "Failed to create product");
  }
  Future<String> deleteProduct(String productId) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );

    final url = "${WebUrls.kDeleteProductUrl}/$productId";

    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: url,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    log("deleteProduct==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data["message"] ?? "Product deleted successfully";
    }

    throw Exception(responseModel.data["message"] ?? "Failed to delete product");
  }
}
