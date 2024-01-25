// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModelNew serviceModelFromJson(String str) =>
    ServiceModelNew.fromJson(json.decode(str));

String serviceModelToJson(ServiceModelNew data) => json.encode(data.toJson());

class ServiceModelNew {
  int status;
  String message;
  List<ServiceListNew> data;
  int totalRecord;
  int totalPages;

  ServiceModelNew({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ServiceModelNew.fromJson(Map<String, dynamic> json) =>
      ServiceModelNew(
        status: json["status"],
        message: json["message"],
        data: List<ServiceListNew>.from(
            json["data"].map((x) => ServiceListNew.fromJson(x))),
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

class ServiceListNew {
  String id;
  String name;
  String categoryId;
  String subCategoryId;
  String uploadId;
  dynamic description;
  int createdAt;
  CategoryInfo categoryInfo;
  CategoryInfo subCategoryInfo;
  UploadInfo uploadInfo;

  ServiceListNew({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.subCategoryId,
    required this.uploadId,
    required this.description,
    required this.createdAt,
    required this.categoryInfo,
    required this.subCategoryInfo,
    required this.uploadInfo,
  });

  factory ServiceListNew.fromJson(Map<String, dynamic> json) => ServiceListNew(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        categoryId: json["category_id"] ?? "",
        subCategoryId: json["sub_category_id"] ?? "",
        uploadId: json["upload_id"] ?? "",
        description: json["description"] ?? "",
        createdAt: json["created_at"],
        categoryInfo: CategoryInfo.fromJson(json["category_info"]),
        subCategoryInfo: CategoryInfo.fromJson(json["sub_category_info"]),
        uploadInfo: UploadInfo.fromJson(json["upload_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "upload_id": uploadId,
        "description": description,
        "created_at": createdAt,
        "category_info": categoryInfo.toJson(),
        "sub_category_info": subCategoryInfo.toJson(),
        "upload_info": uploadInfo.toJson(),
      };
}

class CategoryInfo {
  String name;

  CategoryInfo({
    required this.name,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class UploadInfo {
  String image;

  UploadInfo({required this.image});

  factory UploadInfo.fromJson(Map<String, dynamic> json) => UploadInfo(
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
