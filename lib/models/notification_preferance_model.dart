import 'user_model.dart';

class NotificationPreferences {
  String id = "";
  String userId = "";
  List<String> keywords = [];
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;

  NotificationPreferences.empty();

  NotificationPreferences({
    required this.userId,
    this.keywords = const [],
    this.createdAt,
    this.updatedAt,
    this.user,
  }) {
    id = id;
  }

  NotificationPreferences copyWith({
    String? id,
    String? userId,
    List<String>? keywords,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? user,
  }) {
    return NotificationPreferences(
      userId: userId ?? this.userId,
      keywords: keywords ?? this.keywords,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    )..id = id ?? this.id;
  }

  NotificationPreferences.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? json["id"] ?? id;
    userId = json["userId"] ?? userId;
    keywords = json["keywords"] != null
        ? List<String>.from(json["keywords"])
        : [];
    if (json["createdAt"] != null) {
      createdAt = DateTime.tryParse(json["createdAt"]);
    }
    if (json["updatedAt"] != null) {
      updatedAt = DateTime.tryParse(json["updatedAt"]);
    }

    if (json["user"] != null) {
      user = UserModel.fromJson(json["user"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "keywords": keywords,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "user": user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'NotificationPreferences{'
        'id: $id, '
        'userId: $userId, '
        'keywords: $keywords, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'user: $user'
        '}';
  }
}
