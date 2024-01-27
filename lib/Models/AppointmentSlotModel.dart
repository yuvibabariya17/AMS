// To parse this JSON data, do
//
//     final appointmentSlotModel = appointmentSlotModelFromJson(jsonString);

import 'dart:convert';

AppointmentSlotModel appointmentSlotModelFromJson(String str) => AppointmentSlotModel.fromJson(json.decode(str));

String appointmentSlotModelToJson(AppointmentSlotModel data) => json.encode(data.toJson());

class AppointmentSlotModel {
    int status;
    String message;
    List<SlotList> data;
    int totalRecord;
    int totalPages;

    AppointmentSlotModel({
        required this.status,
        required this.message,
        required this.data,
        required this.totalRecord,
        required this.totalPages,
    });

    factory AppointmentSlotModel.fromJson(Map<String, dynamic> json) => AppointmentSlotModel(
        status: json["status"],
        message: json["message"],
        data: List<SlotList>.from(json["data"].map((x) => SlotList.fromJson(x))),
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

class SlotList {
    String id;
    String vendorId;
    String exportId;
    DateTime dateOfAppointment;
    DateTime timeOfAppointment;
    int createdAt;
    VendorInfo vendorInfo;
    ExpertInfo expertInfo;

    SlotList({
        required this.id,
        required this.vendorId,
        required this.exportId,
        required this.dateOfAppointment,
        required this.timeOfAppointment,
        required this.createdAt,
        required this.vendorInfo,
        required this.expertInfo,
    });

    factory SlotList.fromJson(Map<String, dynamic> json) => SlotList(
        id: json["_id"],
        vendorId: json["vendor_id"],
        exportId: json["export_id"],
        dateOfAppointment: DateTime.parse(json["date_of_appointment"]),
        timeOfAppointment: DateTime.parse(json["time_of_appointment"]),
        createdAt: json["created_at"],
        vendorInfo: VendorInfo.fromJson(json["vendor_info"]),
        expertInfo: ExpertInfo.fromJson(json["expert_info"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor_id": vendorId,
        "export_id": exportId,
        "date_of_appointment": dateOfAppointment.toIso8601String(),
        "time_of_appointment": timeOfAppointment.toIso8601String(),
        "created_at": createdAt,
        "vendor_info": vendorInfo.toJson(),
        "expert_info": expertInfo.toJson(),
    };
}

class ExpertInfo {
    String name;
    int amount;

    ExpertInfo({
        required this.name,
        required this.amount,
    });

    factory ExpertInfo.fromJson(Map<String, dynamic> json) => ExpertInfo(
        name: json["name"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
    };
}

class VendorInfo {
    String vendorType;
    String companyName;
    String contactNo1;
    String emailId;
    String whatsappNo;
    String role;
    String userName;
    String contactPersonName;

    VendorInfo({
        required this.vendorType,
        required this.companyName,
        required this.contactNo1,
        required this.emailId,
        required this.whatsappNo,
        required this.role,
        required this.userName,
        required this.contactPersonName,
    });

    factory VendorInfo.fromJson(Map<String, dynamic> json) => VendorInfo(
        vendorType: json["vendor_type"],
        companyName: json["company_name"],
        contactNo1: json["contact_no1"],
        emailId: json["email_id"],
        whatsappNo: json["whatsapp_no"],
        role: json["role"],
        userName: json["user_name"],
        contactPersonName: json["contact_person_name"],
    );

    Map<String, dynamic> toJson() => {
        "vendor_type": vendorType,
        "company_name": companyName,
        "contact_no1": contactNo1,
        "email_id": emailId,
        "whatsapp_no": whatsappNo,
        "role": role,
        "user_name": userName,
        "contact_person_name": contactPersonName,
    };
}
