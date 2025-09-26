import 'package:matloob_admin/models/user_model.dart';

enum RfqStatus {
  Pending,
  Accepted,
  RevisonRequested,
  Rejected,
  Completed,
  Cancelled,
}

class RfqModel {
  String rfqId = "";
  String category = "";
  String subcategory = "";
  String subSubcategory = "";
  String userId = "";
  bool isWantDelivery = false;
  double? latitude;
  double? longitude;
  String? location;
  String? district;
  String? city;
  RfqStatus status = RfqStatus.Pending;
  String condition = "";
  int clicks = 0;
  int views = 0;
  int phoneClicks = 0;
  String title = "";
  String description = "";
  double price = 0.0;
  List<String> images = [];
  List<String> files = [];
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;

  RfqModel.empty();

  RfqModel({
    required this.category,
    required this.subcategory,
    required this.subSubcategory,
    required this.userId,
    this.isWantDelivery = false,
    this.latitude,
    this.longitude,
    this.location = "",
    this.district = "",
    this.status = RfqStatus.Pending,
    this.city = "",
    this.user,
    required this.condition,
    required this.title,
    required this.description,
    this.price = 0.0,
    this.clicks=0,
    this.views = 0,
    this.images = const [],
    this.files = const [],
    this.createdAt,
    this.updatedAt,
  });

  RfqModel copyWith({
    String? rfqId,
    String? category,
    String? subcategory,
    String? subSubcategory,
    String? userId,
    bool? isWantDelivery,
    double? latitude,
    double? longitude,
    String? location,
    String? district,
    RfqStatus? status,
    String? city,
    String? condition,
    int? clicks,
    int? views,
    int? phoneClicks,
    String? title,
    String? description,
    double? price,
    List<String>? images,
    List<String>? files,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user
  }) {
    return RfqModel(
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      subSubcategory: subSubcategory ?? this.subSubcategory,
      userId: userId ?? this.userId,
      isWantDelivery: isWantDelivery ?? this.isWantDelivery,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
      district: district ?? this.district,
      status: status ?? this.status,
      clicks: clicks ?? this.clicks,
      views: views ?? this.views,
      city: city ?? this.city,
      user: user ?? this.user,
      condition: condition ?? this.condition,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      files: files ?? this.files,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    )..rfqId = rfqId ?? this.rfqId;
  }

  Map<String, dynamic> toCreateJson() {
    return {
      "category": category,
      "subcategory": subcategory,
      "subSubcategory": subSubcategory,
      "userId": userId,
      "isWantDelivery": isWantDelivery,
      "latitude": latitude,
      "longitude": longitude,
      "location": location,
      "district": district,
      "city": city,
      "clicks":clicks,
      "views": views,
      "condition": condition,
      "title": title,
      "description": description,
      "price": price,
      "images": images,
      "files": files,
      "user": user?.toJson(),
    };
  }

  RfqModel.fromJson(Map<String, dynamic> json) {
    rfqId = json["_id"] ?? json["id"] ?? rfqId;
    category = json["category"] ?? category;
    subcategory = json["subcategory"] ?? subcategory;
    subSubcategory = json["subSubcategory"] ?? subSubcategory;
    userId = json["userId"] ?? userId;
    isWantDelivery = json["isWantDelivery"] ?? isWantDelivery;
    latitude = json["latitude"]?.toDouble();
    longitude = json["longitude"]?.toDouble();
    location = json["location"] ?? location;
    district = json["district"] ?? district;
    city = json["city"] ?? city;
    condition = json["condition"] ?? condition;
    clicks = json["clicks"] ?? clicks;
    views = json["views"] ?? views;
    phoneClicks = json["phoneClicks"] ?? phoneClicks;
    title = json["title"] ?? title;
    if (json["user"] != null) {
      user = UserModel.fromJson(json["user"]);
    }
    description = json["description"] ?? description;
    price = json["price"]?.toDouble() ?? price;
    images = List<String>.from(json["images"] ?? []);
    files = List<String>.from(json["files"] ?? []);
    if (json["status"] != null) {
      status = _mapStatus(json["status"]);
    }

    if (json["createdAt"] != null) {
      createdAt = DateTime.tryParse(json["createdAt"]);
    }
    if (json["updatedAt"] != null) {
      updatedAt = DateTime.tryParse(json["updatedAt"]);
    }
  }

  static RfqStatus _mapStatus(String? status) {
    switch (status?.toLowerCase()) {
      case "pending":
        return RfqStatus.Pending;
      case "accepted":
        return RfqStatus.Accepted;
      case "revisionrequested":
      case "revisonrequested":
        return RfqStatus.RevisonRequested;
      case "rejected":
        return RfqStatus.Rejected;
      case "completed":
        return RfqStatus.Completed;
      case "cancelled":
        return RfqStatus.Cancelled;
      default:
        return RfqStatus.Pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": rfqId,
      "category": category,
      "subcategory": subcategory,
      "subSubcategory": subSubcategory,
      "userId": userId,
      "isWantDelivery": isWantDelivery,
      "latitude": latitude,
      "longitude": longitude,
      "location": location,
      "district": district,
      "status": status.toString().split('.').last,
      "city": city,
      "condition": condition,
      "clicks": clicks,
      "views": views,
      "phoneClicks": phoneClicks,
      "title": title,
      "description": description,
      "price": price,
      "images": images,
      "files": files,
      'user: $user, '
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RfqModel{'
        'rfqId: $rfqId, '
        'category: $category, '
        'subcategory: $subcategory, '
        'subSubcategory: $subSubcategory, '
        'userId: $userId, '
        'isWantDelivery: $isWantDelivery, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'location: $location, '
        'district: $district, '
        'status: $status, '
        'city: $city, '
        'condition: $condition, '
        'clicks: $clicks, '
        'views: $views, '
        'phoneClicks: $phoneClicks, '
        'title: $title, '
        'description: $description, '
        'price: $price, '
        'images: $images, '
        'files: $files, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        '}';
  }
}
