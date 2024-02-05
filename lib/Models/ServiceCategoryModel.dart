// To parse this JSON data, do
//
//     final serviceCategoryModel = serviceCategoryModelFromJson(jsonString);

import 'dart:convert';

ServiceCategoryModel serviceCategoryModelFromJson(String str) =>
    ServiceCategoryModel.fromJson(json.decode(str));

String serviceCategoryModelToJson(ServiceCategoryModel data) =>
    json.encode(data.toJson());

class ServiceCategoryModel {
  int status;
  String message;
  List<ServiceCategoryList> data;
  int totalRecord;
  int totalPages;

  ServiceCategoryModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      ServiceCategoryModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: (json?["data"] as List<dynamic>?)
                ?.map((e) => ServiceCategoryList.fromJson(e))
                .toList() ??
            [],
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

class ServiceCategoryList {
  String id;
  String name;
  bool isEnable;
  String uploadId;
  int createdAt;
  UploadInfo uploadInfo;

  ServiceCategoryList({
    required this.id,
    required this.name,
    required this.isEnable,
    required this.uploadId,
    required this.createdAt,
    required this.uploadInfo,
  });

  factory ServiceCategoryList.fromJson(Map<String, dynamic> json) =>
      ServiceCategoryList(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        isEnable: json["is_enable"] ?? false,
        uploadId: json["upload_id"] ?? '',
        createdAt: json["created_at"] ?? 0,
        uploadInfo: UploadInfo.fromJson(json?["upload_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "is_enable": isEnable,
        "upload_id": uploadId,
        "created_at": createdAt,
        "upload_info": uploadInfo.toJson(),
      };
}

class UploadInfo {
  String image;

  UploadInfo({
    required this.image,
  });

  factory UploadInfo.fromJson(Map<String, dynamic> json) => UploadInfo(
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
