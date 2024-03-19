// To parse this JSON data, do
//
//     final reportBugModel = reportBugModelFromJson(jsonString);

import 'dart:convert';

ReportBugModel reportBugModelFromJson(String str) =>
    ReportBugModel.fromJson(json.decode(str));

String reportBugModelToJson(ReportBugModel data) => json.encode(data.toJson());

class ReportBugModel {
  int status;
  String message;
  List<ReportBugList> data;
  int totalRecord;
  int totalPages;

  ReportBugModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ReportBugModel.fromJson(Map<String, dynamic> json) => ReportBugModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        data: List<ReportBugList>.from(
            json["data"].map((x) => ReportBugList.fromJson(x))),
        totalRecord: json["totalRecord"] ?? 0,
        totalPages: json["totalPages"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalRecord": totalRecord,
        "totalPages": totalPages,
      };
}

class ReportBugList {
  String id;
  String vendorId;
  String imgUrl;
  dynamic videoUrl;
  int dateOfSubmit;
  dynamic notes;
  int createdAt;
  VendorInfo vendorInfo;
  ImgUploadInfo imgUploadInfo;

  ReportBugList({
    required this.id,
    required this.vendorId,
    required this.imgUrl,
    required this.videoUrl,
    required this.dateOfSubmit,
    required this.notes,
    required this.createdAt,
    required this.vendorInfo,
    required this.imgUploadInfo,
  });

  factory ReportBugList.fromJson(Map<String, dynamic> json) => ReportBugList(
        id: json["_id"] ?? "",
        vendorId: json["vendor_id"] ?? "",
        imgUrl: json["img_url"] ?? "",
        videoUrl: json["video_url"],
        dateOfSubmit: json["date_of_submit"] ?? 0,
        notes: json["notes"],
        createdAt: json["created_at"] ?? 0,
        vendorInfo: VendorInfo.fromJson(json["vendor_info"] ?? {}),
        imgUploadInfo: ImgUploadInfo.fromJson(json["img_upload_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor_id": vendorId,
        "img_url": imgUrl,
        "video_url": videoUrl,
        "date_of_submit": dateOfSubmit,
        "notes": notes,
        "created_at": createdAt,
        "vendor_info": vendorInfo.toJson(),
        "img_upload_info": imgUploadInfo.toJson(),
      };
}

class ImgUploadInfo {
  String image;

  ImgUploadInfo({
    required this.image,
  });

  factory ImgUploadInfo.fromJson(Map<String, dynamic> json) => ImgUploadInfo(
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
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
        vendorType: json["vendor_type"] ?? "",
        companyName: json["company_name"] ?? "",
        contactNo1: json["contact_no1"] ?? "",
        emailId: json["email_id"] ?? "",
        whatsappNo: json["whatsapp_no"] ?? "",
        role: json["role"] ?? "",
        userName: json["user_name"] ?? "",
        contactPersonName: json["contact_person_name"] ?? "",
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
