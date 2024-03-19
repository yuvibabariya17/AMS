import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) =>
    UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) =>
    json.encode(data.toJson());

class UploadImageModel {
  String status;
  String message;
  ImageData data;
  String file;

  UploadImageModel({
    required this.status,
    required this.message,
    required this.data,
    required this.file,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        status: json["status"],
        message: json["message"],
        data: ImageData.fromJson(json["data"]),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "file": file,
      };
}

class ImageData {
  String image;
  String imageType;
  String imageExtention;
  int createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String id;
  int v;

  ImageData({
    required this.image,
    required this.imageType,
    required this.imageExtention,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.id,
    required this.v,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        image: json["image"] ?? '',
        imageType: json["image_type"] ?? '',
        imageExtention: json["image_extention"] ?? '',
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "image_type": imageType,
        "image_extention": imageExtention,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "_id": id,
        "__v": v,
      };
}
