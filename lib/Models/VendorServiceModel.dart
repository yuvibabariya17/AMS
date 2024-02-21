// To parse this JSON data, do
//
//     final vendorServiceModel = vendorServiceModelFromJson(jsonString);

import 'dart:convert';

VendorServiceModel vendorServiceModelFromJson(String str) =>
    VendorServiceModel.fromJson(json.decode(str));

String vendorServiceModelToJson(VendorServiceModel data) =>
    json.encode(data.toJson());

class VendorServiceModel {
  int status;
  String message;
  List<VendorServiceList> data;
  int totalRecord;
  int totalPages;

  VendorServiceModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory VendorServiceModel.fromJson(Map<String, dynamic> json) =>
      VendorServiceModel(
        status: json["status"],
        message: json["message"],
        data: List<VendorServiceList>.from(
            json["data"].map((x) => VendorServiceList.fromJson(x))),
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

class VendorServiceList {
  String id;
  int fees;
  DateTime oppoxTime;
  int oppoxSetting;
  DateTime oppoxSettingDuration;
  int createdAt;
  int oppox_setting_days_inverval;
  int Total_days;
  VendorInfo vendorInfo;
  ServiceInfo serviceInfo;
  CategoryInfo categoryInfo;
  CategoryInfo subCategoryInfo;

  VendorServiceList({
    required this.id,
    required this.fees,
    required this.oppoxTime,
    required this.oppoxSetting,
    required this.oppoxSettingDuration,
    required this.createdAt,
    required this.oppox_setting_days_inverval,
    required this.Total_days,
    required this.vendorInfo,
    required this.serviceInfo,
    required this.categoryInfo,
    required this.subCategoryInfo,
  });

  factory VendorServiceList.fromJson(Map<String, dynamic> json) =>
      VendorServiceList(
        id: json["_id"] ?? '',
        fees: json["fees"] ?? 0,
        oppoxTime: json["oppox_time"] != null
            ? DateTime.parse(json["oppox_time"])
            : DateTime.now(),
        oppoxSetting: json["oppox_setting"] ?? 0,
        oppoxSettingDuration: json["oppox_setting_duration"] != null
            ? DateTime.parse(json["oppox_setting_duration"])
            : DateTime.now(),
        createdAt: json["created_at"] ?? 0,
        oppox_setting_days_inverval: json["oppox_setting_days_inverval"] ?? 0,
        Total_days: json["Total_days"] ?? 0,
        vendorInfo: VendorInfo.fromJson(json["vendor_info"] ?? {}),
        serviceInfo: ServiceInfo.fromJson(json["service_info"] ?? {}),
        categoryInfo: CategoryInfo.fromJson(json["category_info"] ?? {}),
        subCategoryInfo: CategoryInfo.fromJson(json["sub_category_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fees": fees,
        "oppox_time": oppoxTime.toIso8601String(),
        "oppox_setting": oppoxSetting,
        "oppox_setting_duration": oppoxSettingDuration.toIso8601String(),
        "created_at": createdAt,
        "oppox_setting_days_inverval": oppox_setting_days_inverval,
        "Total_days": Total_days,
        "vendor_info": vendorInfo.toJson(),
        "service_info": serviceInfo.toJson(),
        "category_info": categoryInfo.toJson(),
        "sub_category_info": subCategoryInfo.toJson(),
      };
}

class CategoryInfo {
  String name;

  CategoryInfo({
    required this.name,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        name: json["name"] ?? '',
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
        name: json["name"] ?? '',
        categoryId: json["category_id"] ?? '',
        subCategoryId: json["sub_category_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
      };
}

class VendorInfo {
  dynamic vendorType;
  String companyName;
  dynamic contactNo1;
  String emailId;
  dynamic whatsappNo;
  String role;
  dynamic userName;
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
        companyName: json["company_name"] ?? '',
        contactNo1: json["contact_no1"] ?? '',
        emailId: json["email_id"] ?? '',
        whatsappNo: json["whatsapp_no"] ?? '',
        role: json["role"] ?? '',
        userName: json["user_name"] ?? '',
        contactPersonName: json["contact_person_name"] ?? '',
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
