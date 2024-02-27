// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  int status;
  String message;
  List<StudentList> data;
  int totalRecord;
  int totalPages;

  StudentModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: List<StudentList>.from(
            json["data"].map((x) => StudentList.fromJson(x))),
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

class StudentList {
  String id;
  String name;
  String address;
  String email;
  String contact;
  String photoUrl;
  String idProofUrl;
  int createdAt;
  UrlInfo photoUrlInfo;
  UrlInfo idProofUrlInfo;

  StudentList({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.contact,
    required this.photoUrl,
    required this.idProofUrl,
    required this.createdAt,
    required this.photoUrlInfo,
    required this.idProofUrlInfo,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        id: json["_id"] ?? 0,
        name: json["name"] ?? '',
        address: json["address"] ?? '',
        email: json["email"] ?? '',
        contact: json["contact"] ?? '',
        photoUrl: json["photo_url"] ?? '',
        idProofUrl: json["id_proof_url"] ?? '',
        createdAt: json["created_at"] ?? 0,
        photoUrlInfo: UrlInfo.fromJson(
            json["photo_url_info"] ?? {"image": ""}), // Handle null case
        idProofUrlInfo:
            UrlInfo.fromJson(json["id_proof_url_info"] ?? {"image": ""}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "email": email,
        "contact": contact,
        "photo_url": photoUrl,
        "id_proof_url": idProofUrl,
        "created_at": createdAt,
        "photo_url_info": photoUrlInfo.toJson(),
        "id_proof_url_info": idProofUrlInfo.toJson(),
      };
}

class UrlInfo {
  String image;

  UrlInfo({
    required this.image,
  });

  factory UrlInfo.fromJson(Map<String, dynamic> json) => UrlInfo(
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}
