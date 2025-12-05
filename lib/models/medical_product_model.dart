import 'package:matloob_admin/models/rfq_categories_model.dart';
import 'package:matloob_admin/models/rfq_sub_categories_model.dart';
import 'package:matloob_admin/models/store_model.dart';

class MedicalProducts {
  String id = "";
  String storeId = "";
  String brand = "";
  String country = "";
  dynamic category;
  dynamic subCategory;
  String title = "No available";
  bool isContactForPrice = false;
  List<String> images = [];
  String description = "";
  double price = 0.0;
  int clicks = 0;
  int views = 0;
  int phoneClicks = 0;
  DateTime? createdAt;
  DateTime? updatedAt;
  Store? store;

  MedicalProducts.empty();

  MedicalProducts({
    required this.storeId,
    required this.brand,
    required this.country,
    this.category,
    this.subCategory,
    this.title = "No available",
    this.isContactForPrice = false,
    this.images = const [],
    required this.description,
    this.price = 0.0,
    this.clicks = 0,
    this.views = 0,
    this.phoneClicks = 0,
    this.createdAt,
    this.updatedAt,
    this.store,
  }) {
    id = id;
  }

  MedicalProducts copyWith({
    String? id,
    String? storeId,
    String? brand,
    String? country,
    dynamic category,
    dynamic subCategory,
    String? title,
    bool? isContactForPrice,
    List<String>? images,
    String? description,
    double? price,
    int? clicks,
    int? views,
    int? phoneClicks,
    DateTime? createdAt,
    DateTime? updatedAt,
    Store? store,
  }) {
    return MedicalProducts(
      storeId: storeId ?? this.storeId,
      brand: brand ?? this.brand,
      country: country ?? this.country,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      title: title ?? this.title,
      isContactForPrice: isContactForPrice ?? this.isContactForPrice,
      images: images ?? this.images,
      description: description ?? this.description,
      price: price ?? this.price,
      clicks: clicks ?? this.clicks,
      views: views ?? this.views,
      phoneClicks: phoneClicks ?? this.phoneClicks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      store: store ?? this.store,
    )..id = id ?? this.id;
  }

  MedicalProducts.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? json["id"] ?? id;
    storeId = json["storeId"] ?? storeId;
    brand = json["brand"] ?? brand;
    country = json["country"] ?? country;
    // category = json["category"];
    // subCategory = json["subCategory"];
    json["category"] == null
        ? ""
        : json["category"] != null && json["category"] is String
        ? json["category"]
        : RfqCategoriesModel.fromJson(json["category"]);
    subCategory =
        json["subcategory"] == null
            ? ""
            : json["subCategory"] != null && json["subCategory"] is String
            ? json["subCategory"]
            : RfqSubCategoriesModel.fromJson(json["subCategory"]);
    title = json["title"] ?? title;
    isContactForPrice = json["isContactForPrice"] ?? isContactForPrice;
    images = json["images"] != null ? List<String>.from(json["images"]) : [];
    description = json["description"] ?? description;
    price = (json["price"] != null) ? (json["price"] as num).toDouble() : price;
    clicks = json["clicks"] ?? clicks;
    views = json["views"] ?? views;
    phoneClicks = json["phoneClicks"] ?? phoneClicks;

    if (json["createdAt"] != null) {
      createdAt = DateTime.tryParse(json["createdAt"]);
    }
    if (json["updatedAt"] != null) {
      updatedAt = DateTime.tryParse(json["updatedAt"]);
    }

    if (json["store"] != null) {
      store = Store.fromJson(json["store"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "storeId": storeId,
      "brand": brand,
      "country": country,
      "category": category,
      "subCategory": subCategory,
      "title": title,
      "isContactForPrice": isContactForPrice,
      "images": images,
      "description": description,
      "price": price,
      "clicks": clicks,
      "views": views,
      "phoneClicks": phoneClicks,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "store": store?.toJson(),
    };
  }

  @override
  String toString() {
    return 'MedicalProducts{'
        'id: $id, '
        'storeId: $storeId, '
        'brand: $brand, '
        'country: $country, '
        'category: $category, '
        'subCategory: $subCategory, '
        'title: $title, '
        'isContactForPrice: $isContactForPrice, '
        'images: $images, '
        'description: $description, '
        'price: $price, '
        'clicks: $clicks, '
        'views: $views, '
        'phoneClicks: $phoneClicks, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'store: $store, '
        '}';
  }
}
