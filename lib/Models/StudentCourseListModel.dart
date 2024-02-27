// To parse this JSON data, do
//
//     final studentCourseListModel = studentCourseListModelFromJson(jsonString);

import 'dart:convert';

StudentCourseListModel studentCourseListModelFromJson(String str) =>
    StudentCourseListModel.fromJson(json.decode(str));

String studentCourseListModelToJson(StudentCourseListModel data) =>
    json.encode(data.toJson());

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

  factory StudentCourseListModel.fromJson(Map<String, dynamic> json) =>
      StudentCourseListModel(
        status: json["status"],
        message: json["message"],
        data: List<ListofStudentCourse>.from(
            json["data"].map((x) => ListofStudentCourse.fromJson(x))),
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
  String studentId;
  String courseId;
  int fees;
  String startingFrom;
  String otherNotes;
  String idProofUrl;
  int createdAt;
  StudentInfo studentInfo;
    CourseInfo courseInfo;
  IdProofUrlInfo idProofUrlInfo;

  ListofStudentCourse({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.fees,
    required this.startingFrom,
    required this.otherNotes,
    required this.idProofUrl,
    required this.createdAt,
      required this.studentInfo,
        required this.courseInfo,
    required this.idProofUrlInfo,
  });

  factory ListofStudentCourse.fromJson(Map<String, dynamic> json) =>
      ListofStudentCourse(
        id: json["_id"] ?? '',
        studentId: json["student_id"] ?? '',
        courseId: json["course_id"] ?? '',
        fees: json["fees"] ?? 0,
        startingFrom: json["starting_from"].toString() ?? '',
        otherNotes: json["other_notes"] ?? '',
        idProofUrl: json["id_proof_url"] ?? '',
        createdAt: json["created_at"] ?? 0,
          studentInfo: StudentInfo.fromJson(json["student_info"]),
        courseInfo: CourseInfo.fromJson(json["course_info"]),
        idProofUrlInfo: json["id_proof_url_info"] != null
            ? IdProofUrlInfo.fromJson(json["id_proof_url_info"])
            : IdProofUrlInfo(image: ''),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student_id": studentId,
        "course_id": courseId,
        "fees": fees,
        "starting_from": startingFrom,
        "other_notes": otherNotes,
        "id_proof_url": idProofUrl,
        "created_at": createdAt,
           "student_info": studentInfo.toJson(),
        "course_info": courseInfo.toJson(),
        "id_proof_url_info": idProofUrlInfo.toJson(),
      };
}
class CourseInfo {
    String name;
    int duration;
    int fees;

    CourseInfo({
        required this.name,
        required this.duration,
        required this.fees,
    });

    factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
        name: json["name"],
        duration: json["duration"],
        fees: json["fees"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
        "fees": fees,
    };
}
class StudentInfo {
    String name;
    String address;
    String email;
    String contact;

    StudentInfo({
        required this.name,
        required this.address,
        required this.email,
        required this.contact,
    });

    factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "contact": contact,
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
