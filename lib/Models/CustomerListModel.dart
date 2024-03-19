// To parse this JSON data, do
//
//     final customerListModel = customerListModelFromJson(jsonString);

import 'dart:convert';

CustomerListModel customerListModelFromJson(String str) =>
    CustomerListModel.fromJson(json.decode(str));

String customerListModelToJson(CustomerListModel data) =>
    json.encode(data.toJson());

class CustomerListModel {
  int status;
  String message;
  List<ListofCustomer> data;
  int totalRecord;
  int totalPages;

  CustomerListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) =>
      CustomerListModel(
        status: json["status"],
        message: json["message"],
        data: List<ListofCustomer>.from(
            json["data"].map((x) => ListofCustomer.fromJson(x))),
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

class ListofCustomer {
  String id;
  String name;
  String contactNo;
  String whatsappNo;
  String email;
  String pic;
  String description;
  DateTime dateOfBirth;
  DateTime dateOfAnniversary;
  String address;
  int createdAt;
  PicInfo? picInfo;
  VendorInfo? vendorInfo;

  ListofCustomer({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.whatsappNo,
    required this.email,
    required this.pic,
    required this.description,
    required this.dateOfBirth,
    required this.dateOfAnniversary,
    required this.address,
    required this.createdAt,
    this.picInfo,
    this.vendorInfo,
  });

  factory ListofCustomer.fromJson(Map<String, dynamic> json) => ListofCustomer(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        contactNo: json["contact_no"] ?? '',
        whatsappNo: json["whatsapp_no"] ?? '',
        email: json["email"] ?? '',
        pic: json["pic"] ?? '',
        description: json["description"] ?? '',
        dateOfBirth: DateTime.parse(json["date_of_birth"] ?? ""),
        dateOfAnniversary: DateTime.parse(json["date_of_anniversary"] ?? ''),
        address: json["address"] ?? '',
        createdAt: json["created_at"] ?? 0,
        picInfo: json["pic_info"] != null
            ? PicInfo.fromJson(json["pic_info"])
            : null,
        vendorInfo: json["vendor_info"] != null
            ? VendorInfo.fromJson(json["vendor_info"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "contact_no": contactNo,
        "whatsapp_no": whatsappNo,
        "email": email,
        "pic": pic,
        "description": description,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "date_of_anniversary": dateOfAnniversary.toIso8601String(),
        "address": address,
        "created_at": createdAt,
        "pic_info": picInfo?.toJson(),
        "vendor_info": vendorInfo?.toJson(),
      };
}

class PicInfo {
  String image;

  PicInfo({
    required this.image,
  });

  factory PicInfo.fromJson(Map<String, dynamic> json) => PicInfo(
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image,
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
