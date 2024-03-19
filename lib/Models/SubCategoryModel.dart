// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  int status;
  String message;
  List<ServiceSubCategoryList> data;
  int totalRecord;
  int totalPages;

  SubCategoryModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: (json?["data"] as List<dynamic>?)
                ?.map((e) => ServiceSubCategoryList.fromJson(e))
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

class ServiceSubCategoryList {
  String id;
  String name;
  String categoryId;
  String uploadId;
  int createdAt;
  CategoryInfo categoryInfo;
  UploadInfo uploadInfo;

  ServiceSubCategoryList({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.uploadId,
    required this.createdAt,
    required this.categoryInfo,
    required this.uploadInfo,
  });

  factory ServiceSubCategoryList.fromJson(Map<String, dynamic> json) =>
      ServiceSubCategoryList(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        categoryId: json["category_id"] ?? '',
        uploadId: json["upload_id"] ?? '',
        createdAt: json["created_at"] ?? 0,
        categoryInfo: CategoryInfo.fromJson(json?["category_info"] ?? {}),
        uploadInfo: UploadInfo.fromJson(json?["upload_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_id": categoryId,
        "upload_id": uploadId,
        "created_at": createdAt,
        "category_info": categoryInfo.toJson(),
        "upload_info": uploadInfo.toJson(),
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

class UploadInfo {
  String image;

  UploadInfo({
    required this.image,
  });

  factory UploadInfo.fromJson(Map<String, dynamic> json) => UploadInfo(
        image: json?["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
