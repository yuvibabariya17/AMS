// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  int status;
  String message;
  List<ServiceList> data;
  int totalRecord;
  int totalPages;

  ServiceModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        status: json["status"],
        message: json["message"],
        data: List<ServiceList>.from(
            json["data"].map((x) => ServiceList.fromJson(x))),
        totalRecord: json["totalRecord"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalRecord": totalRecord,
        "totalPages": totalPages,
      };
}

class ServiceList {
  String id;
  int fees;
  DateTime oppoxTime;
  int oppoxSetting;
  DateTime oppoxSettingDuration;
  int oppoxSettingDaysInverval;
  int createdAt;
  VendorInfo vendorInfo;
  ServiceInfo? serviceInfo; // Make it nullable
  CategoryInfo? categoryInfo; // Make it nullable
  CategoryInfo? subCategoryInfo;

  ServiceList({
    required this.id,
    required this.fees,
    required this.oppoxTime,
    required this.oppoxSetting,
    required this.oppoxSettingDuration,
    required this.oppoxSettingDaysInverval,
    required this.createdAt,
    required this.vendorInfo,
    this.serviceInfo,
    this.categoryInfo,
    this.subCategoryInfo,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        id: json["_id"],
        fees: json["fees"],
        oppoxTime: DateTime.parse(json["oppox_time"]),
        oppoxSetting: json["oppox_setting"],
        oppoxSettingDuration: DateTime.parse(json["oppox_setting_duration"]),
        oppoxSettingDaysInverval: json["oppox_setting_days_inverval"],
        createdAt: json["created_at"],
        vendorInfo: VendorInfo.fromJson(json["vendor_info"]),
        serviceInfo: json["service_info"] == null
            ? null
            : ServiceInfo.fromJson(json["service_info"]),
        categoryInfo: json["category_info"] == null
            ? null
            : CategoryInfo.fromJson(json["category_info"]),
        subCategoryInfo: json["sub_category_info"] == null
            ? null
            : CategoryInfo.fromJson(json["sub_category_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fees": fees,
        "oppox_time": oppoxTime.toIso8601String(),
        "oppox_setting": oppoxSetting,
        "oppox_setting_duration": oppoxSettingDuration.toIso8601String(),
        "oppox_setting_days_inverval": oppoxSettingDaysInverval,
        "created_at": createdAt,
        "vendor_info": vendorInfo.toJson(),
        "service_info": serviceInfo?.toJson(),
        "category_info": categoryInfo?.toJson(),
        "sub_category_info": subCategoryInfo?.toJson(),
      };
}

class CategoryInfo {
  String name;

  CategoryInfo({
    required this.name,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class ServiceInfo {
  String name;
  String categoryId;
  String subCategoryId;

  ServiceInfo({
    required this.name,
    required this.categoryId,
    required this.subCategoryId,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
        name: json["name"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
      };
}

class VendorInfo {
  String vendorType;
  String companyName;
  String contactNo1;
  String emailId;
  String whatsappNo;
  String role;
  String userName;
  String contactPersonName;

  VendorInfo({
    required this.vendorType,
    required this.companyName,
    required this.contactNo1,
    required this.emailId,
    required this.whatsappNo,
    required this.role,
    required this.userName,
    required this.contactPersonName,
  });

  factory VendorInfo.fromJson(Map<String, dynamic> json) => VendorInfo(
        vendorType: json["vendor_type"],
        companyName: json["company_name"],
        contactNo1: json["contact_no1"],
        emailId: json["email_id"],
        whatsappNo: json["whatsapp_no"],
        role: json["role"],
        userName: json["user_name"],
        contactPersonName: json["contact_person_name"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_type": vendorType,
        "company_name": companyName,
        "contact_no1": contactNo1,
        "email_id": emailId,
        "whatsapp_no": whatsappNo,
        "role": role,
        "user_name": userName,
        "contact_person_name": contactPersonName,
      };
}
