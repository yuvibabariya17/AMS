// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  int status;
  String message;
  List<ListofAppointment> data;
  int totalRecord;
  int totalPages;

  AppointmentModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: (json["data"] as List<dynamic>?)
                ?.map((x) => ListofAppointment.fromJson(x))
                .toList() ??
            [],
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

class ListofAppointment {
  String id;
  String vendorId;
  String customerId;
  String exportId;
  String vendorServiceId;
  String appointmentSlotId;
  int amount;
  String appointmentType;
  DateTime dateOfAppointment;
  int duration;
  int makeReminder;
  int isConfirmed;
  int isFinished;
  int isCancelled;
  int isReschedule;
  String notes;
  int createdAt;
  VendorInfo vendorInfo;
  CustomerInfo customerInfo;
  AppointmentSlotInfo appointmentSlotInfo;
  VendorServiceInfo vendorServiceInfo;
  ExpertInfo expertInfo;

  ListofAppointment({
    required this.id,
    required this.vendorId,
    required this.customerId,
    required this.exportId,
    required this.vendorServiceId,
    required this.appointmentSlotId,
    required this.amount,
    required this.appointmentType,
    required this.dateOfAppointment,
    required this.duration,
    required this.makeReminder,
    required this.isConfirmed,
    required this.isFinished,
    required this.isCancelled,
    required this.isReschedule,
    required this.notes,
    required this.createdAt,
    required this.vendorInfo,
    required this.customerInfo,
    required this.appointmentSlotInfo,
    required this.vendorServiceInfo,
    required this.expertInfo,
  });

  factory ListofAppointment.fromJson(Map<String, dynamic> json) =>
      ListofAppointment(
        id: json["_id"] ?? '',
        vendorId: json["vendor_id"] ?? '',
        customerId: json["customer_id"] ?? '',
        exportId: json["export_id"] ?? '',
        vendorServiceId: json["vendor_service_id"] ?? '',
        appointmentSlotId: json["appointment_slot_id"] ?? '',
        amount: json["amount"] ?? 0,
        appointmentType: json["appointment_type"] ?? '',
        dateOfAppointment: json["date_of_appointment"] != null
            ? DateTime.parse(json["date_of_appointment"])
            : DateTime.now(),
        duration: json["duration"] ?? 0,
        makeReminder: json["make_reminder"] ?? 0,
        isConfirmed: json["is_confirmed"] ?? 0,
        isFinished: json["is_finished"] ?? 0,
        isCancelled: json["is_cancelled"] ?? 0,
        isReschedule: json["is_reschedule"] ?? 0,
        notes: json["notes"] ?? '',
        createdAt: json["created_at"] ?? 0,
        vendorInfo: VendorInfo.fromJson(json["vendor_info"] ?? {}),
        expertInfo: ExpertInfo.fromJson(json["expert_info"]),
        customerInfo: CustomerInfo.fromJson(json["customer_info"] ?? {}),
        appointmentSlotInfo:
            AppointmentSlotInfo.fromJson(json["appointment_slot_info"] ?? {}),
        vendorServiceInfo:
            VendorServiceInfo.fromJson(json["vendor_service_info"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor_id": vendorId,
        "customer_id": customerId,
        "export_id": exportId,
        "vendor_service_id": vendorServiceId,
        "appointment_slot_id": appointmentSlotId,
        "amount": amount,
        "appointment_type": appointmentType,
        "date_of_appointment": dateOfAppointment.toIso8601String(),
        "duration": duration,
        "make_reminder": makeReminder,
        "is_confirmed": isConfirmed,
        "is_finished": isFinished,
        "is_cancelled": isCancelled,
        "is_reschedule": isReschedule,
        "notes": notes,
        "created_at": createdAt,
        "vendor_info": vendorInfo.toJson(),
        "customer_info": customerInfo.toJson(),
        "expert_info": expertInfo.toJson(),
        "appointment_slot_info": appointmentSlotInfo.toJson(),
        "vendor_service_info": vendorServiceInfo.toJson(),
      };
}

class AppointmentSlotInfo {
  DateTime dateOfAppointment;
  DateTime timeOfAppointment;

  AppointmentSlotInfo({
    required this.dateOfAppointment,
    required this.timeOfAppointment,
  });

  factory AppointmentSlotInfo.fromJson(Map<String, dynamic> json) =>
      AppointmentSlotInfo(
        dateOfAppointment: json["date_of_appointment"] != null
            ? DateTime.parse(json["date_of_appointment"])
            : DateTime.now(),
        timeOfAppointment: json["time_of_appointment"] != null
            ? DateTime.parse(json["time_of_appointment"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "date_of_appointment": dateOfAppointment.toIso8601String(),
        "time_of_appointment": timeOfAppointment.toIso8601String(),
      };
}

class CustomerInfo {
  String name;
  String contactNo;
  String whatsappNo;
  String email;
  //DateTime dateOfBirth;
  // DateTime dateOfAnniversary;
  String address;

  CustomerInfo({
    required this.name,
    required this.contactNo,
    required this.whatsappNo,
    required this.email,
    //required this.dateOfBirth,
    //required this.dateOfAnniversary,
    required this.address,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        name: json["name"] ?? '',
        contactNo: json["contact_no"] ?? '',
        whatsappNo: json["whatsapp_no"] ?? '',
        email: json["email"] ?? '',
        // dateOfBirth: DateTime.parse(json["date_of_birth"]??''),
        //dateOfAnniversary: DateTime.parse(json["date_of_anniversary"]),
        address: json["address"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact_no": contactNo,
        "whatsapp_no": whatsappNo,
        "email": email,
        //"date_of_birth": dateOfBirth.toIso8601String(),
        //"date_of_anniversary": dateOfAnniversary.toIso8601String(),
        "address": address,
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
        vendorType: json["vendor_type"] ?? '',
        companyName: json["company_name"] ?? '',
        contactNo1: json["contact_no1"] ?? '',
        emailId: json["email_id"] ?? '',
        whatsappNo: json["whatsapp_no"] ?? '',
        role: json["role"] ?? '',
        userName: json["user_name"] ?? '',
        contactPersonName: json["contact_person_name"] ?? '',
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

class VendorServiceInfo {
  String serviceId;
  int fees;
  DateTime oppoxTime;
  int oppoxSetting;
  DateTime oppoxSettingDuration;
  int oppoxSettingDaysInverval;
  ServiceInfo serviceInfo;

  VendorServiceInfo({
    required this.serviceId,
    required this.fees,
    required this.oppoxTime,
    required this.oppoxSetting,
    required this.oppoxSettingDuration,
    required this.oppoxSettingDaysInverval,
    required this.serviceInfo,
  });

  factory VendorServiceInfo.fromJson(Map<String, dynamic> json) =>
      VendorServiceInfo(
        serviceId: json["service_id"] ?? '',
        fees: json["fees"] ?? 0,
        oppoxTime: json["oppox_time"] != null
            ? DateTime.parse(json["oppox_time"])
            : DateTime.now(),
        oppoxSetting: json["oppox_setting"] ?? 0,
        oppoxSettingDuration: json["oppox_setting_duration"] != null
            ? DateTime.parse(json["oppox_setting_duration"])
            : DateTime.now(),
        oppoxSettingDaysInverval: json["oppox_setting_days_inverval"] ?? 0,
        serviceInfo: json["service_info"] != null
            ? ServiceInfo.fromJson(json["service_info"])
            : ServiceInfo(name: ''),
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "fees": fees,
        "oppox_time": oppoxTime.toIso8601String(),
        "oppox_setting": oppoxSetting,
        "oppox_setting_duration": oppoxSettingDuration.toIso8601String(),
        "oppox_setting_days_inverval": oppoxSettingDaysInverval,
        "service_info": serviceInfo.toJson(),
      };
}

class ServiceInfo {
  String name;

  ServiceInfo({
    required this.name,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => ServiceInfo(
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
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
