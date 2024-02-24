// // To parse this JSON data, do
// //
// //     final homeScreenModel = homeScreenModelFromJson(jsonString);

// import 'dart:convert';

// HomeScreenModel homeScreenModelFromJson(String str) =>
//     HomeScreenModel.fromJson(json.decode(str));

// String homeScreenModelToJson(HomeScreenModel data) =>
//     json.encode(data.toJson());

// class HomeScreenModel {
//   int status;
//   String message;
//   List<SlotList> data;

//   HomeScreenModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
//       HomeScreenModel(
//         status: json["status"] ?? 0,
//         message: json["message"] ?? '',
//         data:
//             List<SlotList>.from(json["data"].map((x) => SlotList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class SlotList {
//   String id;
//   // String vendorId;
//   // String exportId;
//   DateTime dateOfAppointment;
//   DateTime timeOfAppointment;
//   // int createdAt;
//   // dynamic updatedAt;
//   // dynamic deletedAt;
//   // dynamic createdBy;
//   // dynamic updatedBy;
//   // dynamic deletedBy;
//   // int v;
//   List<dynamic> appointment;

//   SlotList({
//     required this.id,
//     // required this.vendorId,
//     // required this.exportId,
//     required this.dateOfAppointment,
//     required this.timeOfAppointment,
//     // required this.createdAt,
//     // required this.updatedAt,
//     // required this.deletedAt,
//     // required this.createdBy,
//     // required this.updatedBy,
//     // required this.deletedBy,
//     // required this.v,
//     required this.appointment,
//   });

//   factory SlotList.fromJson(Map<String, dynamic> json) => SlotList(
//         id: json["_id"] ?? '',
//         // vendorId: json["vendor_id"] ?? '',
//         // exportId: json["export_id"] ?? '',
//         dateOfAppointment: DateTime.parse(json["date_of_appointment"]),
//         timeOfAppointment: DateTime.parse(json["time_of_appointment"]),
//         // createdAt: json["created_at"] ?? 0,
//         // updatedAt: json["updated_at"],
//         // deletedAt: json["deleted_at"],
//         // createdBy: json["created_by"],
//         // updatedBy: json["updated_by"],
//         // deletedBy: json["deleted_by"],
//         // v: json["__v"] ?? 0,
//         appointment: List<dynamic>.from(json["appointment"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         // "vendor_id": vendorId,
//         // "export_id": exportId,
//         "date_of_appointment": dateOfAppointment.toIso8601String(),
//         "time_of_appointment": timeOfAppointment.toIso8601String(),
//         // "created_at": createdAt,
//         // "updated_at": updatedAt,
//         // "deleted_at": deletedAt,
//         // "created_by": createdBy,
//         // "updated_by": updatedBy,
//         // "deleted_by": deletedBy,
//         // "__v": v,
//         "appointment": List<dynamic>.from(appointment.map((x) => x)),
//       };
// }




// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

import 'dart:convert';

HomeScreenModel homeScreenModelFromJson(String str) => HomeScreenModel.fromJson(json.decode(str));

String homeScreenModelToJson(HomeScreenModel data) => json.encode(data.toJson());

class HomeScreenModel {
    int status;
    String message;
    List<AppointmentList> data;

    HomeScreenModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory HomeScreenModel.fromJson(Map<String, dynamic> json) => HomeScreenModel(
        status: json["status"],
        message: json["message"],
        data: List<AppointmentList>.from(json["data"].map((x) => AppointmentList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AppointmentList {
    String id;
    DateTime dateOfAppointment;
    DateTime timeOfAppointment;
    List<AppointmentInfo> appointmentInfo;

    AppointmentList({
        required this.id,
        required this.dateOfAppointment,
        required this.timeOfAppointment,
        required this.appointmentInfo,
    });

    factory AppointmentList.fromJson(Map<String, dynamic> json) => AppointmentList(
        id: json["_id"],
        dateOfAppointment: DateTime.parse(json["date_of_appointment"]),
        timeOfAppointment: DateTime.parse(json["time_of_appointment"]),
        appointmentInfo: List<AppointmentInfo>.from(json["appointment_info"].map((x) => AppointmentInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date_of_appointment": dateOfAppointment.toIso8601String(),
        "time_of_appointment": timeOfAppointment.toIso8601String(),
        "appointment_info": List<dynamic>.from(appointmentInfo.map((x) => x.toJson())),
    };
}

class AppointmentInfo {
    String id;
    int amount;
    String appointmentType;
    DateTime dateOfAppointment;
    int duration;
    int makeReminder;
    int isConfirmed;
    String notes;
    CustomerInfo customerInfo;
    String service;

    AppointmentInfo({
        required this.id,
        required this.amount,
        required this.appointmentType,
        required this.dateOfAppointment,
        required this.duration,
        required this.makeReminder,
        required this.isConfirmed,
        required this.notes,
        required this.customerInfo,
        required this.service,
    });

    factory AppointmentInfo.fromJson(Map<String, dynamic> json) => AppointmentInfo(
        id: json["_id"],
        amount: json["amount"],
        appointmentType: json["appointment_type"],
        dateOfAppointment: DateTime.parse(json["date_of_appointment"]),
        duration: json["duration"],
        makeReminder: json["make_reminder"],
        isConfirmed: json["is_confirmed"],
        notes: json["notes"],
        customerInfo: CustomerInfo.fromJson(json["customer_info"]),
        service: json["service"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "appointment_type": appointmentType,
        "date_of_appointment": dateOfAppointment.toIso8601String(),
        "duration": duration,
        "make_reminder": makeReminder,
        "is_confirmed": isConfirmed,
        "notes": notes,
        "customer_info": customerInfo.toJson(),
        "service": service,
    };
}

class CustomerInfo {
    String id;
    String name;
    String contactNo;
    String whatsappNo;
      

    CustomerInfo({
        required this.id,
        required this.name,
        required this.contactNo,
        required this.whatsappNo,
    });

    factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        id: json["_id"],
        name: json["name"],
        contactNo: json["contact_no"],
        whatsappNo: json["whatsapp_no"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "contact_no": contactNo,
        "whatsapp_no": whatsappNo,
    };
}



