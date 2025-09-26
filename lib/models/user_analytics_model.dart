class UserWithAnalytics {
  String id;
  String? name;
  String? email;
  String? mobile;
  String? companyName;
  bool isVerified;
  String status;
  String roles;
  String? profileImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int totalRfqs;
  int rfqSupplierResponse;
  int rfqNoResponse;

  UserWithAnalytics({
    required this.id,
    this.name,
    this.email,
    this.mobile,
    this.companyName,
    this.isVerified = false,
    this.status = "Active",
    this.roles = "user",
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.totalRfqs = 0,
    this.rfqSupplierResponse = 0,
    this.rfqNoResponse = 0,
  });

  factory UserWithAnalytics.fromJson(Map<String, dynamic> json) {
    return UserWithAnalytics(
      id: json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      companyName: json['companyName'],
      isVerified: json['isVerified'] ?? false,
      status: json['status'] ?? 'Active',
      roles: json['roles'] ?? 'user',
      profileImage: json['profileImage'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      totalRfqs: json['totalRfqs'] ?? 0,
      rfqSupplierResponse: json['rfqSupplierResponse'] ?? 0,
      rfqNoResponse: json['rfqNoResponse'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'companyName': companyName,
      'isVerified': isVerified,
      'status': status,
      'roles': roles,
      'profileImage': profileImage,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalRfqs': totalRfqs,
      'rfqSupplierResponse': rfqSupplierResponse,
      'rfqNoResponse': rfqNoResponse,
    };
  }
}
