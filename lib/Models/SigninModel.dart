import 'dart:convert';

GetLoginModel getLoginModelFromJson(String str) =>
    GetLoginModel.fromJson(json.decode(str));

String getLoginModelToJson(GetLoginModel data) => json.encode(data.toJson());

class GetLoginModel {
  int status;
  String message;
  SignInData data;

  GetLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetLoginModel.fromJson(Map<String, dynamic> json) => GetLoginModel(
        status: json["status"],
        message: json["message"],
        data: SignInData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class SignInData {
  String id;
  String vendorType;
  String companyName;
  String companyAddress;
  String contactNo1;
  String contactNo2;
  String emailId;
  String whatsappNo;
  String address;
  String role;
  String userName;
  String contactPersonName;
  String logoUrl;
  String brouchersUrl;
  String profilePic;
  List<dynamic> propertyPics;
  String token;
  int isActive;
  int isBlocked;
  int createdAt;
  String byWhichDevice;
  int v;

  SignInData({
    required this.id,
    required this.vendorType,
    required this.companyName,
    required this.companyAddress,
    required this.contactNo1,
    required this.contactNo2,
    required this.emailId,
    required this.whatsappNo,
    required this.address,
    required this.role,
    required this.userName,
    required this.contactPersonName,
    required this.logoUrl,
    required this.brouchersUrl,
    required this.profilePic,
    required this.propertyPics,
    required this.token,
    required this.isActive,
    required this.isBlocked,
    required this.createdAt,
    required this.byWhichDevice,
    required this.v,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
        id: json["_id"],
        vendorType: json["vendor_type"] ?? '',
        companyName: json["company_name"] ?? '',
        companyAddress: json["company_address"] ?? '',
        contactNo1: json["contact_no1"] ?? '',
        contactNo2: json["contact_no2"] ?? '',
        emailId: json["email_id"] ?? '',
        whatsappNo: json["whatsapp_no"] ?? '',
        address: json["address"] ?? '',
        role: json["role"] ?? '',
        userName: json["user_name"] ?? '',
        contactPersonName: json["contact_person_name"] ?? '',
        logoUrl: json["logo_url"] ?? '',
        brouchersUrl: json["brouchers_url"] ?? '',
        profilePic: json["profile_pic"] ?? '',
        propertyPics: List<dynamic>.from(json["property_pics"].map((x) => x)),
        token: json["token"],
        isActive: json["is_active"],
        isBlocked: json["is_blocked"],
        createdAt: json["created_at"],
        byWhichDevice: json["by_which_device"] ?? '',
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor_type": vendorType,
        "company_name": companyName,
        "company_address": companyAddress,
        "contact_no1": contactNo1,
        "contact_no2": contactNo2,
        "email_id": emailId,
        "whatsapp_no": whatsappNo,
        "address": address,
        "role": role,
        "user_name": userName,
        "contact_person_name": contactPersonName,
        "logo_url": logoUrl,
        "brouchers_url": brouchersUrl,
        "profile_pic": profilePic,
        "property_pics": List<dynamic>.from(propertyPics.map((x) => x)),
        "token": token,
        "is_active": isActive,
        "is_blocked": isBlocked,
        "created_at": createdAt,
        "by_which_device": byWhichDevice,
        "__v": v,
      };
}
