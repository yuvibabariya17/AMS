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
        data: List<BrandCatList>.from(
            json["data"].map((x) => BrandCatList.fromJson(x))),
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

class BrandCatList {
  String id;
  String name;
  String uploadId;
  String productCategoryId;
  String description;
  int createdAt;
  UploadInfo uploadInfo;
  ProductCategoryInfo productCategoryInfo;

  BrandCatList({
    required this.id,
    required this.name,
    required this.uploadId,
    required this.productCategoryId,
    required this.description,
    required this.createdAt,
    required this.uploadInfo,
    required this.productCategoryInfo,
  });

  factory BrandCatList.fromJson(Map<String, dynamic> json) => BrandCatList(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        uploadId: json["upload_id"] ?? "",
        productCategoryId: json["product_category_id"] ?? "",
        description: json["description"] ?? "",
        createdAt: json["created_at"] ?? 0,
        uploadInfo: UploadInfo.fromJson(json["upload_info"] ?? {}),
        productCategoryInfo:
            ProductCategoryInfo.fromJson(json["product_category_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "upload_id": uploadId,
        "product_category_id": productCategoryId,
        "description": description,
        "created_at": createdAt,
        "upload_info": uploadInfo.toJson(),
        "product_category_info": productCategoryInfo.toJson(),
      };
}

class ProductCategoryInfo {
  String name;
  String description;

  ProductCategoryInfo({
    required this.name,
    required this.description,
  });

  factory ProductCategoryInfo.fromJson(Map<String, dynamic> json) =>
      ProductCategoryInfo(
        name: json["name"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
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
