import 'dart:convert';

RfqSubCategoriesModel rfqSubCategoriesModelFromJson(String str) => RfqSubCategoriesModel.fromJson(json.decode(str));

String rfqSubCategoriesModelToJson(RfqSubCategoriesModel data) => json.encode(data.toJson());

class RfqSubCategoriesModel {
  String? id;
  String? enName;
  String? arName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryId;

  RfqSubCategoriesModel({this.id, this.enName, this.arName, this.createdAt, this.updatedAt, this.categoryId});

  factory RfqSubCategoriesModel.fromJson(Map<String, dynamic> json) => RfqSubCategoriesModel(
    id: json["id"],
    enName: json["en_name"],
    arName: json["ar_name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    categoryId: json["categoryId"],
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
