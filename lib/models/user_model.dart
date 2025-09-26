import 'package:matloob_admin/models/notification_preferance_model.dart';
import 'package:matloob_admin/models/rfq_model.dart';
import 'package:matloob_admin/models/store_click_model.dart';
import 'package:matloob_admin/models/store_model.dart';
import 'package:matloob_admin/models/rfq_click_model.dart';

class UserModel {
  String id = "";
  String? email;
  String? mobile;
  String? password;
  String? name;
  bool isVerified = false;
  String? companyName;
  bool isNotificationEnabled = true;
  String? profileImage;
  String status = "Active"; 
  String roles = "user";
  DateTime? createdAt;
  DateTime? updatedAt;
  List<RfqModel> rfqs = [];
  Store? supplier;
  NotificationPreferences? notificationPreferences;
  List<StoreClick> storeClicks = [];
  List<RFQClick> rfqClicks = [];

  UserModel.empty();

  UserModel({
    this.email,
    this.mobile,
    this.password,
    this.name,
    this.isVerified = false,
    this.companyName,
    this.isNotificationEnabled = true,
    this.profileImage,
    this.status = "Active",
    this.roles = "user",
    this.createdAt,
    this.updatedAt,
    this.rfqs = const [],
    this.supplier,
    this.notificationPreferences,
    this.storeClicks = const [],
    this.rfqClicks = const [],
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? mobile,
    String? password,
    String? name,
    bool? isVerified,
    String? companyName,
    bool? isNotificationEnabled,
    String? profileImage,
    String? status,
    String? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<RfqModel>? rfqs,
    Store? supplier,
    NotificationPreferences? notificationPreferences,
    List<StoreClick>? storeClicks,
    List<RFQClick>? rfqClicks,
  }) {
    return UserModel(
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      name: name ?? this.name,
      isVerified: isVerified ?? this.isVerified,
      companyName: companyName ?? this.companyName,
      isNotificationEnabled:
          isNotificationEnabled ?? this.isNotificationEnabled,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rfqs: rfqs ?? this.rfqs,
      supplier: supplier ?? this.supplier,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
      storeClicks: storeClicks ?? this.storeClicks,
      rfqClicks: rfqClicks ?? this.rfqClicks,
    )..id = id ?? this.id;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? json["id"] ?? id;
    email = json["email"];
    mobile = json["mobile"];
    password = json["password"];
    name = json["name"];
    isVerified = json["isVerified"] ?? isVerified;
    companyName = json["companyName"];
    isNotificationEnabled =
        json["isNotificationEnabled"] ?? isNotificationEnabled;
    profileImage = json["profileImage"];
    status = json["status"] ?? status;
    roles = json["roles"] ?? roles;

    if (json["createdAt"] != null) {
      createdAt = DateTime.tryParse(json["createdAt"]);
    }
    if (json["updatedAt"] != null) {
      updatedAt = DateTime.tryParse(json["updatedAt"]);
    }

    if (json["rfqs"] != null) {
      rfqs = List<RfqModel>.from(json["rfqs"].map((e) => RfqModel.fromJson(e)));
    }
    if (json["supplier"] != null) {
      supplier = Store.fromJson(json["supplier"]);
    }
    if (json["notificationPreferences"] != null) {
      notificationPreferences =
          NotificationPreferences.fromJson(json["notificationPreferences"]);
    }
    if (json["storeClicks"] != null) {
      storeClicks = List<StoreClick>.from(
          json["storeClicks"].map((e) => StoreClick.fromJson(e)));
    }
    if (json["rfqClicks"] != null) {
      rfqClicks = List<RFQClick>.from(
          json["rfqClicks"].map((e) => RFQClick.fromJson(e)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "mobile": mobile,
      "password": password,
      "name": name,
      "isVerified": isVerified,
      "companyName": companyName,
      "isNotificationEnabled": isNotificationEnabled,
      "profileImage": profileImage,
      "status": status,
      "roles": roles,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "rfqs": rfqs.map((e) => e.toJson()).toList(),
      "supplier": supplier?.toJson(),
      "notificationPreferences": notificationPreferences?.toJson(),
      "storeClicks": storeClicks.map((e) => e.toJson()).toList(),
      "rfqClicks": rfqClicks.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UserModel{'
        'id: $id, '
        'email: $email, '
        'mobile: $mobile, '
        'password: $password, '
        'name: $name, '
        'isVerified: $isVerified, '
        'companyName: $companyName, '
        'isNotificationEnabled: $isNotificationEnabled, '
        'profileImage: $profileImage, '
        'status: $status, '
        'roles: $roles, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'rfqs: $rfqs, '
        'supplier: $supplier, '
        'notificationPreferences: $notificationPreferences, '
        'storeClicks: $storeClicks, '
        'rfqClicks: $rfqClicks'
        '}';
  }
}
