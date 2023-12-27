// To parse this JSON data, do
//
//     final deleteSuccessModel = deleteSuccessModelFromJson(jsonString);

import 'dart:convert';

DeleteSuccessModel deleteSuccessModelFromJson(String str) =>
    DeleteSuccessModel.fromJson(json.decode(str));

String deleteSuccessModelToJson(DeleteSuccessModel data) =>
    json.encode(data.toJson());

class DeleteSuccessModel {
  int status;
  String message;

  DeleteSuccessModel({
    required this.status,
    required this.message,
  });

  factory DeleteSuccessModel.fromJson(Map<String, dynamic> json) =>
      DeleteSuccessModel(
        status: json["status"],
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
