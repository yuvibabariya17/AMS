class AppointmentListModel {
  int status;
  String message;
  List<ListofAppointment> data;
  int totalRecord;
  int totalPages;

  AppointmentListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });
}

class ListofAppointment {
  String id;
  String vendorId;
  String customerId;
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

  ListofAppointment({
    required this.id,
    required this.vendorId,
    required this.customerId,
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
  });
}

class AppointmentSlotInfo {
  DateTime dateOfAppointment;
  DateTime timeOfAppointment;

  AppointmentSlotInfo({
    required this.dateOfAppointment,
    required this.timeOfAppointment,
  });
}

class CustomerInfo {
  String name;
  String contactNo;
  String whatsappNo;
  String email;
  DateTime dateOfBirth;
  DateTime dateOfAnniversary;
  String address;

  CustomerInfo({
    required this.name,
    required this.contactNo,
    required this.whatsappNo,
    required this.email,
    required this.dateOfBirth,
    required this.dateOfAnniversary,
    required this.address,
  });
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
}

class ServiceInfo {
  String name;

  ServiceInfo({
    required this.name,
  });
}
