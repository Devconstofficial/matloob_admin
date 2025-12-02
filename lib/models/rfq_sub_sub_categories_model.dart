import 'dart:convert';

RfqSubSubCategoriesModel rfqSubSubCategoriesModelFromJson(String str) => RfqSubSubCategoriesModel.fromJson(json.decode(str));

String rfqSubSubCategoriesModelToJson(RfqSubSubCategoriesModel data) => json.encode(data.toJson());

class RfqSubSubCategoriesModel {
  String? id;
  String? enName;
  String? arName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;
  String? subCategoryId;

  RfqSubSubCategoriesModel({this.id, this.enName, this.arName, this.createdAt, this.updatedAt, this.categoryId, this.subCategoryId});

  factory RfqSubSubCategoriesModel.fromJson(Map<String, dynamic> json) => RfqSubSubCategoriesModel(
    id: json["id"],
    enName: json["en_name"],
    arName: json["ar_name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "en_name": enName,
    "ar_name": arName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "categoryId": categoryId,
  };
}
