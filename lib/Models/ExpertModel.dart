// To parse this JSON data, do
//
//     final expertModel = expertModelFromJson(jsonString);

import 'dart:convert';

ExpertModel expertModelFromJson(String str) =>
    ExpertModel.fromJson(json.decode(str));

String expertModelToJson(ExpertModel data) => json.encode(data.toJson());

class ExpertModel {
  int status;
  String message;
  List<ExpertList> data;
  int totalRecord;
  int totalPages;

  ExpertModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ExpertModel.fromJson(Map<String, dynamic> json) => ExpertModel(
        status: json["status"],
        message: json["message"] ?? '',
        data: List<ExpertList>.from(
            json["data"].map((x) => ExpertList.fromJson(x))),
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

class ExpertList {
  String id;
  String name;
  int amount;
  int createdAt;
  VendorInfo vendorInfo;
  ServiceInfo? serviceInfo;

  ExpertList({
    required this.id,
    required this.name,
    required this.amount,
    required this.createdAt,
    required this.vendorInfo,
    this.serviceInfo,
  });

  factory ExpertList.fromJson(Map<String, dynamic> json) => ExpertList(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        amount: json["amount"],
        createdAt: json["created_at"],
        vendorInfo: VendorInfo.fromJson(json["vendor_info"]),
        serviceInfo: json["service_info"] == null
            ? null
            : ServiceInfo.fromJson(json["service_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "amount": amount,
        "created_at": createdAt,
        "vendor_info": vendorInfo.toJson(),
        "service_info": serviceInfo?.toJson(),
      };
}

class ServiceInfo {
  String id;
  String name;
  dynamic description;

  ServiceInfo({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}

class VendorInfo {
  String id;
  String userName;

  VendorInfo({
    required this.id,
    required this.userName,
  });

  factory VendorInfo.fromJson(Map<String, dynamic> json) => VendorInfo(
        id: json["_id"] ?? '',
        userName: json["user_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_name": userName,
      };
}
