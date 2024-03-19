// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryModel productCategoryModelFromJson(String str) =>
    ProductCategoryModel.fromJson(json.decode(str));

String productCategoryModelToJson(ProductCategoryModel data) =>
    json.encode(data.toJson());

class ProductCategoryModel {
  int status;
  String message;
  List<ProductCategoryList> data;
  int totalRecord;
  int totalPages;

  ProductCategoryModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => ProductCategoryList.fromJson(x))
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

class ProductCategoryList {
  String id;
  String name;
  String uploadId;
  String description;
  int createdAt;
  UploadInfo uploadInfo;

  ProductCategoryList({
    required this.id,
    required this.name,
    required this.uploadId,
    required this.description,
    required this.createdAt,
    required this.uploadInfo,
  });

  factory ProductCategoryList.fromJson(Map<String, dynamic> json) =>
      ProductCategoryList(
        id: json["_id"],
        name: json["name"],
        uploadId: json["upload_id"],
        description: json["description"],
        createdAt: json["created_at"],
        uploadInfo: UploadInfo.fromJson(json["upload_info"]),
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
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
