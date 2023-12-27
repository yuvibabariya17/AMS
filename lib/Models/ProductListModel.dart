// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  int status;
  String message;
  List<ListofProduct> data;
  int totalRecord;
  int totalPages;

  ProductListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        status: json["status"],
        message: json["message"] ?? '',
        data: List<ListofProduct>.from(
            json["data"].map((x) => ListofProduct.fromJson(x))),
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

class ListofProduct {
  String id;
  String name;
  String uploadId;
  String description;
  String productCategoryId;
  int amount;
  int qty;
  int createdAt;
  UploadInfo uploadInfo;
  ProductCategoryInfo productCategoryInfo;

  ListofProduct({
    required this.id,
    required this.name,
    required this.uploadId,
    required this.description,
    required this.productCategoryId,
    required this.amount,
    required this.qty,
    required this.createdAt,
    required this.uploadInfo,
    required this.productCategoryInfo,
  });

  factory ListofProduct.fromJson(Map<String, dynamic> json) => ListofProduct(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        uploadId: json["upload_id"] ?? '',
        description: json["description"] ?? '',
        productCategoryId: json["product_category_id"] ?? '',
        amount: json["amount"],
        qty: json["qty"],
        createdAt: json["created_at"],
        uploadInfo: UploadInfo.fromJson(json["upload_info"]),
        productCategoryInfo:
            ProductCategoryInfo.fromJson(json["product_category_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "upload_id": uploadId,
        "description": description,
        "product_category_id": productCategoryId,
        "amount": amount,
        "qty": qty,
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
