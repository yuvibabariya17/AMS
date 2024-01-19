// To parse this JSON data, do
//
//     final studentCourseListModel = studentCourseListModelFromJson(jsonString);

import 'dart:convert';

StudentCourseListModel studentCourseListModelFromJson(String str) => StudentCourseListModel.fromJson(json.decode(str));

String studentCourseListModelToJson(StudentCourseListModel data) => json.encode(data.toJson());

class StudentCourseListModel {
    int status;
    String message;
    List<ListofStudentCourse> data;
    int totalRecord;
    int totalPages;

    StudentCourseListModel({
        required this.status,
        required this.message,
        required this.data,
        required this.totalRecord,
        required this.totalPages,
    });

    factory StudentCourseListModel.fromJson(Map<String, dynamic> json) => StudentCourseListModel(
        status: json["status"],
        message: json["message"],
        data: List<ListofStudentCourse>.from(json["data"].map((x) => ListofStudentCourse.fromJson(x))),
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

class ListofStudentCourse {
    String id;
    int fees;
    int startingFrom;
    String otherNotes;
    String idProofUrl;
    int createdAt;
    IdProofUrlInfo idProofUrlInfo;

    ListofStudentCourse({
        required this.id,
        required this.fees,
        required this.startingFrom,
        required this.otherNotes,
        required this.idProofUrl,
        required this.createdAt,
        required this.idProofUrlInfo,
    });

    factory ListofStudentCourse.fromJson(Map<String, dynamic> json) => ListofStudentCourse(
        id: json["_id"] ?? '',
        fees: json["fees"]?? 0,
        startingFrom: json["starting_from"] ?? 0,
        otherNotes: json["other_notes"]?? '',
        idProofUrl: json["id_proof_url"] ?? '',
        createdAt: json["created_at"]?? 0,
       idProofUrlInfo: json["id_proof_url_info"] != null ? IdProofUrlInfo.fromJson(json["id_proof_url_info"]) : IdProofUrlInfo(image: ''),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fees": fees,
        "starting_from": startingFrom,
        "other_notes": otherNotes,
        "id_proof_url": idProofUrl,
        "created_at": createdAt,
        "id_proof_url_info": idProofUrlInfo.toJson(),
    };
}

class IdProofUrlInfo {
    String image;

    IdProofUrlInfo({
        required this.image,
    });

    factory IdProofUrlInfo.fromJson(Map<String, dynamic> json) => IdProofUrlInfo(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}
