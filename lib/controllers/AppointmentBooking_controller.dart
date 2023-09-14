import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Models/sign_in_form_validation.dart';
import '../Screens/TimeSlot.dart';
import 'internet_controller.dart';

class AppointmentBookingController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode CustomerNode;
  late FocusNode ServiceNode;
  late FocusNode SlotNode;
  late FocusNode AmountNode;
  late FocusNode NoteNode;
  late FocusNode RemindNode;
  late FocusNode expertNode;

  late TextEditingController Customerctr;
  late TextEditingController Servicectr;
  late TextEditingController Slotctr;
  late TextEditingController Amountctr;
  late TextEditingController Notectr;
  late TextEditingController Remindctr;
  late TextEditingController expertctr;

  late TextEditingController datectr;
  late FocusNode dateNode;

  final formKey = GlobalKey<FormState>();
  RxBool isClickd = false.obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    _getStorage = GetStorage();

    CustomerNode = FocusNode();
    ServiceNode = FocusNode();
    SlotNode = FocusNode();
    AmountNode = FocusNode();
    NoteNode = FocusNode();
    RemindNode = FocusNode();
    expertNode = FocusNode();
    dateNode = FocusNode();

    Customerctr = TextEditingController();
    expertctr = TextEditingController();
    Servicectr = TextEditingController();
    datectr = TextEditingController();
    Slotctr = TextEditingController();
    Amountctr = TextEditingController();
    Notectr = TextEditingController();
    Remindctr = TextEditingController();
    datectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  RxList<Choice> choices = [
    Choice(
      title: '11:30 AM',
      isSelected: false,
    ),
    Choice(
      title: '01:30 AM',
      isSelected: false,
    ),
    Choice(
      title: '12:30 PM',
      isSelected: false,
    ),
    Choice(
      title: '01:30 PM',
      isSelected: false,
    ),
    Choice(title: '02:30 PM', isSelected: false),
    Choice(title: '04:00 PM', isSelected: false),
    Choice(title: '05:00 PM', isSelected: false),
    Choice(title: '06:00 PM', isSelected: false),
    Choice(title: '07:00 PM', isSelected: false),
    Choice(title: '08:00 PM', isSelected: false),
    Choice(title: '09:00 PM', isSelected: false),
    Choice(title: '12:00 PM', isSelected: false),
  ].obs;

  void setOnClick(bool isClick) {
    isClickd.value = !isClick;
    update();
  }

  void updateDate(date) {
    datectr.text = date;
    print("PICKED_DATE${datectr.value}");
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;
  var ServiceModel = ValidationModel(null, null, isValidate: false).obs;
  var SlotModel = ValidationModel(null, null, isValidate: false).obs;
  var AmountModel = ValidationModel(null, null, isValidate: false).obs;
  var NoteModel = ValidationModel(null, null, isValidate: false).obs;
  var RemindModel = ValidationModel(null, null, isValidate: false).obs;
  var expertModel = ValidationModel(null, null, isValidate: false).obs;
  var dateModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (CustomerModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ServiceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (expertModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (dateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (SlotModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (AmountModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NoteModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (RemindModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateCustomer(String? val) {
    CustomerModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateService(String? val) {
    ServiceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Service Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateExpert(String? val) {
    ServiceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Expert";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateDate(String? val) {
    ServiceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Date";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateAmount(String? val) {
    AmountModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Amount";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNote(String? val) {
    NoteModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Notes";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateRemind(String? val) {
    RemindModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Reminder for Customer";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void navigate() {
    // Get.to(const SignUpScreen(false));
  }
}
