import 'package:matloob_admin/models/medical_product_model.dart';
import 'package:matloob_admin/models/store_click_model.dart';
import 'user_model.dart';

enum StoreStatus { Pending,
  Accepted,
  RevisonRequested,
  Rejected,
  Completed,
  Cancelled }

class Store {
  String id = "";
  String logo = "";
  String companyName = "";
  String companyNumber = "";
  String location = "";
  StoreStatus storeStatus = StoreStatus.Pending;
  String speciality = "";
  int clicks = 0;
  int views = 0;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MedicalProducts> medicalProducts = [];
  String userId = "";
  UserModel? user;
  List<StoreClick> storeClicks = [];

  Store.empty();

  Store({
    required this.logo,
    required this.companyName,
    required this.companyNumber,
    required this.location,
    this.storeStatus = StoreStatus.Pending,
    required this.speciality,
    this.clicks = 0,
    this.views=0,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    this.user,
    this.medicalProducts = const [],
    this.storeClicks = const [],
  }) {
    id = id;
  }

  Store copyWith({
    String? id,
    String? logo,
    String? companyName,
    String? companyNumber,
    String? location,
    StoreStatus? storeStatus,
    String? speciality,
    int? clicks,
    int? views,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    UserModel? user,
    List<MedicalProducts>? medicalProducts,
    List<StoreClick>? storeClicks,
  }) {
    return Store(
      logo: logo ?? this.logo,
      companyName: companyName ?? this.companyName,
      companyNumber: companyNumber ?? this.companyNumber,
      location: location ?? this.location,
      storeStatus: storeStatus ?? this.storeStatus,
      speciality: speciality ?? this.speciality,
      clicks: clicks ?? this.clicks,
      views: views ?? this.views,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      medicalProducts: medicalProducts ?? this.medicalProducts,
      storeClicks: storeClicks ?? this.storeClicks,
    )..id = id ?? this.id;
  }

  Store.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? json["id"] ?? id;
    logo = json["logo"] ?? logo;
    companyName = json["companyName"] ?? companyName;
    companyNumber = json["companyNumber"] ?? companyNumber;
    location = json["location"] ?? location;
    speciality = json["speciality"] ?? speciality;
    clicks = json["clicks"] ?? clicks;
    views = json["views"] ?? views;

    if (json["storeStatus"] != null) {
      storeStatus = StoreStatus.values.firstWhere(
        (e) => e.toString().split('.').last.toLowerCase() ==
            json["storeStatus"].toString().toLowerCase(),
        orElse: () => StoreStatus.Pending,
      );
    }

    if (json["createdAt"] != null) {
      createdAt = DateTime.tryParse(json["createdAt"]);
    }
    if (json["updatedAt"] != null) {
      updatedAt = DateTime.tryParse(json["updatedAt"]);
    }

    userId = json["userId"] ?? userId;

    if (json["user"] != null) {
      user = UserModel.fromJson(json["user"]);
    }

    // FIX: Look for "MedicalProducts" first, then fallback to "medicalProducts"
    List<dynamic>? productsJson = json["MedicalProducts"] ?? json["medicalProducts"];

    if (productsJson != null) {
      medicalProducts = List<MedicalProducts>.from(
        productsJson.map((e) => MedicalProducts.fromJson(e)),
      );
    }

    if (json["storeClicks"] != null) {
      storeClicks = List<StoreClick>.from(
        json["storeClicks"].map((e) => StoreClick.fromJson(e)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "logo": logo,
      "companyName": companyName,
      "companyNumber": companyNumber,
      "location": location,
      "storeStatus": storeStatus.toString().split('.').last,
      "speciality": speciality,
      "clicks": clicks,
      "views": views,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "userId": userId,
      "user": user?.toJson(),
      "medicalProducts": medicalProducts.map((e) => e.toJson()).toList(),
      "storeClicks": storeClicks.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Store{'
        'id: $id, '
        'logo: $logo, '
        'companyName: $companyName, '
        'companyNumber: $companyNumber, '
        'location: $location, '
        'storeStatus: $storeStatus, '
        'speciality: $speciality, '
        'clicks: $clicks, '
        'views: $views, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'userId: $userId, '
        'user: $user, '
        'medicalProducts: $medicalProducts, '
        'storeClicks: $storeClicks'
        '}';
  }
}