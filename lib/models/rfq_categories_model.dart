import 'dart:convert';

RfqCategoriesModel rfqCategoriesModelFromJson(String str) => RfqCategoriesModel.fromJson(json.decode(str));

String rfqCategoriesModelToJson(RfqCategoriesModel data) => json.encode(data.toJson());

class RfqCategoriesModel {
  String? id;
  String? enName;
  String? arName;
  DateTime? createdAt;
  DateTime? updatedAt;

  RfqCategoriesModel({this.id, this.enName, this.arName, this.createdAt, this.updatedAt});

  factory RfqCategoriesModel.fromJson(Map<String, dynamic> json) => RfqCategoriesModel(
    id: json["id"],
    enName: json["en_name"],
    arName: json["ar_name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "en_name": enName,
    "ar_name": arName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
