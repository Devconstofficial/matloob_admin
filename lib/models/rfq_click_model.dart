import 'package:matloob_admin/models/rfq_categories_model.dart';
import 'package:matloob_admin/models/rfq_sub_categories_model.dart';
import 'package:matloob_admin/models/user_model.dart';

class RFQClick {
  String id;
  String title;
  dynamic category;
  dynamic subcategory;
  String status;
  int clicks;
  int phoneClicks;
  int views;
  DateTime? createdAt;
  DateTime? updatedAt;

  List<UserModel> usersWhoClicked;

  RFQClick({
    required this.id,
    required this.title,
    required this.category,
    required this.subcategory,
    required this.status,
    required this.clicks,
    required this.phoneClicks,
    required this.views,
    this.createdAt,
    this.updatedAt,
    List<UserModel>? usersWhoClicked,
  }) : usersWhoClicked = usersWhoClicked ?? [];

  factory RFQClick.fromJson(Map<String, dynamic> json) {
    return RFQClick(
      id: json["_id"] ?? json["id"] ?? '',
      title: json["title"] ?? '',
      // category: json["category"] ?? '',
      // subcategory: json["subcategory"] ?? '',
      category:
          json["category"] == null
              ? ""
              : json["category"] != null && json["category"] is String
              ? json["category"]
              : RfqCategoriesModel.fromJson(json["category"]),
      subcategory:
          json["subcategory"] == null
              ? ""
              : json["subcategory"] != null && json["subcategory"] is String
              ? json["subcategory"]
              : RfqSubCategoriesModel.fromJson(json["subcategory"]),
      status: json["status"] ?? '',
      clicks: json["clicks"] ?? 0,
      phoneClicks: json["phoneClicks"] ?? 0,
      views: json["views"] ?? 0,
      createdAt: json["createdAt"] != null ? DateTime.tryParse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"]) : null,
      usersWhoClicked: (json["usersWhoClicked"] as List<dynamic>?)?.map((e) => UserModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "category": category,
      "subcategory": subcategory,
      "status": status,
      "clicks": clicks,
      "phoneClicks": phoneClicks,
      "views": views,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "usersWhoClicked": usersWhoClicked.map((e) => e.toJson()).toList(),
    };
  }
}
