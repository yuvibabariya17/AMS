// To parse this JSON data, do
//
//     final productCategoryListModel = productCategoryListModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryListModel productCategoryListModelFromJson(String str) => ProductCategoryListModel.fromJson(json.decode(str));

String productCategoryListModelToJson(ProductCategoryListModel data) => json.encode(data.toJson());

class ProductCategoryListModel {
    int status;
    String message;
    List<ListProductCategory> data;
    int totalRecord;
    int totalPages;

    ProductCategoryListModel({
        required this.status,
        required this.message,
        required this.data,
        required this.totalRecord,
        required this.totalPages,
    });

    factory ProductCategoryListModel.fromJson(Map<String, dynamic> json) => ProductCategoryListModel(
        status: json["status"]?? 0,
        message: json["message"]?? '',
       data: (json["data"] as List<dynamic>?)
              ?.map((x) => ListProductCategory.fromJson(x))
              .toList() ??
          [],
        totalRecord: json["totalRecord"]?? 0,
        totalPages: json["totalPages"]?? 0,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalRecord": totalRecord,
        "totalPages": totalPages,
    };
}

class ListProductCategory {
    String id;
    String name;
    String uploadId;
    String description;
    int createdAt;
    UploadInfo uploadInfo;

    ListProductCategory({
        required this.id,
        required this.name,
        required this.uploadId,
        required this.description,
        required this.createdAt,
        required this.uploadInfo,
    });

    factory ListProductCategory.fromJson(Map<String, dynamic> json) => ListProductCategory(
        id: json["_id"]??'',
        name: json["name"]??'',
        uploadId: json["upload_id"]??'',
        description: json["description"]??'',
        createdAt: json["created_at"]?? 0,
       uploadInfo: json["upload_info"] != null ? UploadInfo.fromJson(json["upload_info"]) : UploadInfo(image: ''), 
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
