// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'dart:convert';

PackageModel packageModelFromJson(String str) => PackageModel.fromJson(json.decode(str));

String packageModelToJson(PackageModel data) => json.encode(data.toJson());

class PackageModel {
    int status;
    String message;
    List<PackageList> data;
    int totalRecord;
    int totalPages;

    PackageModel({
        required this.status,
        required this.message,
        required this.data,
        required this.totalRecord,
        required this.totalPages,
    });

    factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        status: json["status"],
        message: json["message"],
        data: List<PackageList>.from(json["data"].map((x) => PackageList.fromJson(x))),
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

class PackageList {
    String id;
    String vendorId;
    String name;
    int actFees;
    int packFees;
    String otherNotes;
    DateTime durationFrom;
    DateTime durationTo;
    int createdAt;
    VendorInfo? vendorInfo;

    PackageList({
        required this.id,
        required this.vendorId,
        required this.name,
        required this.actFees,
        required this.packFees,
        required this.otherNotes,
        required this.durationFrom,
        required this.durationTo,
        required this.createdAt,
        this.vendorInfo,
    });

    factory PackageList.fromJson(Map<String, dynamic> json) => PackageList(
        id: json["_id"],
        vendorId: json["vendor_id"],
        name: json["name"],
        actFees: json["act_fees"],
        packFees: json["pack_fees"],
        otherNotes: json["other_notes"],
        durationFrom: DateTime.parse(json["duration_from"]),
        durationTo: DateTime.parse(json["duration_to"]),
        createdAt: json["created_at"],
        vendorInfo: json["vendor_info"] == null ? null : VendorInfo.fromJson(json["vendor_info"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor_id": vendorId,
        "name": name,
        "act_fees": actFees,
        "pack_fees": packFees,
        "other_notes": otherNotes,
        "duration_from": durationFrom.toIso8601String(),
        "duration_to": durationTo.toIso8601String(),
        "created_at": createdAt,
        "vendor_info": vendorInfo?.toJson(),
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
