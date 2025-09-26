import 'package:matloob_admin/models/user_model.dart';

class StoreClick {
  String id;
  String companyName;
  String companyNumber;
  String location;
  String speciality;
  String storeStatus;
  int clicks;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  UserModel? owner;
  List<UserModel> usersWhoClicked;

  StoreClick({
    required this.id,
    required this.companyName,
    required this.companyNumber,
    required this.location,
    required this.speciality,
    required this.storeStatus,
    required this.clicks,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.owner,
    List<UserModel>? usersWhoClicked,
  }) : usersWhoClicked = usersWhoClicked ?? [];

  factory StoreClick.fromJson(Map<String, dynamic> json) {
    return StoreClick(
      id: json["_id"] ?? json["id"] ?? '',
      companyName: json["companyName"] ?? '',
      companyNumber: json["companyNumber"] ?? '',
      location: json["location"] ?? '',
      speciality: json["speciality"] ?? '',
      storeStatus: json["storeStatus"] ?? '',
      clicks: json["clicks"] ?? 0,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
      userId: json["userId"],
      owner: json["owner"] != null ? UserModel.fromJson(json["owner"]) : null,
      usersWhoClicked: (json["usersWhoClicked"] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "companyName": companyName,
      "companyNumber": companyNumber,
      "location": location,
      "speciality": speciality,
      "storeStatus": storeStatus,
      "clicks": clicks,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "userId": userId,
      "owner": owner?.toJson(),
      "usersWhoClicked": usersWhoClicked.map((e) => e.toJson()).toList(),
    };
  }
}
