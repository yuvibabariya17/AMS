// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ListOfProduct productListModelFromJson(String str) => ListOfProduct.fromJson(json.decode(str));

String productListModelToJson(ListOfProduct data) => json.encode(data.toJson());

class ListOfProduct {
    int status;
    String message;
    List<DataList> data;
    int totalRecord;
    int totalPages;

    ListOfProduct({
        required this.status,
        required this.message,
        required this.data,
        required this.totalRecord,
        required this.totalPages,
    });

    factory ListOfProduct.fromJson(Map<String, dynamic> json) => ListOfProduct(
        status: json["status"],
        message: json["message"],
        data: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
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

class DataList {
    String id;
    String name;
    String uploadId;
    String description;
    int createdAt;
    UploadInfo uploadInfo;

    DataList({
        required this.id,
        required this.name,
        required this.uploadId,
        required this.description,
        required this.createdAt,
        required this.uploadInfo,
    });

    factory DataList.fromJson(Map<String, dynamic> json) => DataList(
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
