import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Config/apicall_constant.dart';
import '../Models/SigninModel.dart';
import '../Models/sign_in_form_validation.dart';
import '../Screens/DashboardScreen.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';

class AddexpertController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode ServiceNode, ExpertNode, PriceNode;

  late TextEditingController Servicectr, Expertctr, Pricectr;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    _getStorage = GetStorage();

    ServiceNode = FocusNode();
    ExpertNode = FocusNode();
    PriceNode = FocusNode();

    Servicectr = TextEditingController();
    Expertctr = TextEditingController();
    Pricectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var ServiceModel = ValidationModel(null, null, isValidate: false).obs;
  var ExpertModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (ServiceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ExpertModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (PriceModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else {
      isFormInvalidate.value = true;
    }
  }

  void validateExpertname(String? val) {
    ExpertModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Expert Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateServicename(String? val) {
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

  void validatePrice(String? val) {
    PriceModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Price";
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

  void AddExpertApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context,  Strings.noInternetConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();
      var response = await Repository.post({
        "name": Expertctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "service_id": Servicectr.text.toString().trim(),
        "amount": Pricectr.text.toString().trim(),
      }, ApiUrl.addExpert, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      var responseDetail = GetLoginModel.fromJson(data);
      if (response.statusCode == 200) {
        if (responseDetail.status == 1) {
          // UserPreferences().saveSignInInfo(responseDetail.data);
          UserPreferences().setToken(responseDetail.data.token.toString());
          Get.to(const dashboard());
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseDetail.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context,  Strings.servererror,
          callback: () {});
      loadingIndicator.hide(context);
    }
  }

  showDialogForScreen(context, String message, {Function? callback}) {
    showMessage(
        context: context,
        callback: () {
          if (callback != null) {
            callback();
          }
          return true;
        },
        message: message,
        title: "Add Expert",
        negativeButton: '',
        positiveButton: "Continue");
  }
}
