// To parse this JSON data, do
//
//     final brandCategoryModel = brandCategoryModelFromJson(jsonString);

import 'dart:convert';

BrandCategoryModel brandCategoryModelFromJson(String str) =>
    BrandCategoryModel.fromJson(json.decode(str));

String brandCategoryModelToJson(BrandCategoryModel data) =>
    json.encode(data.toJson());

class BrandCategoryModel {
  int status;
  String message;
  List<BrandCatList> data;
  int totalRecord;
  int totalPages;

  BrandCategoryModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory BrandCategoryModel.fromJson(Map<String, dynamic> json) =>
      BrandCategoryModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => BrandCatList.fromJson(x))
                .toList() ??
            [],
        totalRecord: json["totalRecord"] ?? '',
        totalPages: json["totalPages"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalRecord": totalRecord,
        "totalPages": totalPages,
      };
}

class BrandCatList {
  String id;
  String name;
  String uploadId;
  String description;
  int createdAt;
  UploadInfo uploadInfo;

  BrandCatList({
    required this.id,
    required this.name,
    required this.uploadId,
    required this.description,
    required this.createdAt,
    required this.uploadInfo,
  });

  factory BrandCatList.fromJson(Map<String, dynamic> json) => BrandCatList(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        uploadId: json["upload_id"] ?? '',
        description: json["description"] ?? '',
        createdAt: json["created_at"] ?? 0,
        uploadInfo: UploadInfo.fromJson(json["upload_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "upload_id": uploadId,
        "description": description,
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
