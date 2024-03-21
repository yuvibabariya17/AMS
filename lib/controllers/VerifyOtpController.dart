import 'dart:async';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'internet_controller.dart';

class VerifyOtpController extends GetxController {
  RxBool isEmailVerified = false.obs;
  RxBool isMobileVerified = false.obs;
  RxString registeredUserId = ''.obs;
  RxBool isLoading = true.obs;
  bool? isVerify;
  bool? isPassword;

  late FocusNode oneNode, twoNode, threeNode, fourNode;

  late TextEditingController fieldOne, fieldTwo, fieldThree, fieldFour;

  RxString fNameError = ''.obs;
  Rx<ScreenState> states = ScreenState.apiLoading.obs;
  RxString message = "".obs;

  //final InternetController _networkManager = Get.find<InternetController>();

  final otpController = TextEditingController();
  final otpNode = FocusNode();
  bool showError = false;
  final InternetController networkManager = Get.find<InternetController>();
  String mobileNo = "";

  void updateData(BuildContext context, bool ispassword, String mobNo) {
    isPassword = ispassword;
    mobileNo = mobNo;
    update();
    // verifyUserPhoneNumber(context);
  }

  @override
  void onInit() {
    oneNode = FocusNode();
    twoNode = FocusNode();
    threeNode = FocusNode();
    fourNode = FocusNode();

    fieldOne = TextEditingController();
    fieldTwo = TextEditingController();
    fieldThree = TextEditingController();
    fieldFour = TextEditingController();
    fieldOne.text = '';
    fieldTwo.text = '';
    fieldThree.text = '';
    fieldFour.text = '';
    isLoading.value = false;
    fieldOne.addListener(() {
      // enableSignUpButton();
    });
    fieldTwo.addListener(() {
      // enableSignUpButton();
    });
    fieldThree.addListener(() {
      //enableSignUpButton();
    });
    fieldFour.addListener(() {
      //enableSignUpButton();
    });
    super.onInit();
  }

  @override
  void onClose() {
    fieldOne.dispose();
    fieldTwo.dispose();
    fieldThree.dispose();
    fieldFour.dispose();
    otpController.dispose();
    otpNode.dispose();
    super.onClose();
  }

  final GlobalKey<FormState> otpkey = GlobalKey<FormState>();
  RxString errorFName = ''.obs;

  String getOTP() {
    String otp = fieldOne.text.trim() +
        fieldTwo.text.trim() +
        fieldThree.text.trim() +
        fieldFour.text.trim();

    return otp;
  }

  // void getOtpScreen(context, String otp, String mobile) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   logcat("statusCode", "getOtpScreen");

  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, LocalizationKeys.noConnection.tr,
  //           callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     loadingIndicator.show(context, '');

  //     var response = await Repository.post({
  //       "MobileNumber": mobile,
  //       "Otp": otpController.text,
  //     }, ApiUrl.getVerifyotp);

  //     loadingIndicator.hide(context);
  //     var data = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       if (data['status'] == true) {
  //         // showDialogForScreen(context, data['message'].toString(),
  //         //     callback: () {
  //         //   Get.to(ResetPassScreen(
  //         //     fromProfile: false,
  //         //     mobile: mobile,
  //         //   ));
  //         // });
  //         Get.to(ResetPassScreen(
  //           fromProfile: false,
  //           mobile: mobile,
  //         ));
  //       } else {
  //         showDialogForScreen(context, data['message'], callback: () {});
  //       }
  //     } else {
  //       states.value = ScreenState.apiError;
  //       showDialogForScreen(context, data['message'], callback: () {
  //         startTimer();
  //         FocusScope.of(context).requestFocus(otpNode);
  //         otpController.text = "";
  //       });
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     // getOtpScreen(context, otp, mobile);
  //     // showDialogForScreen(context, LocalizationKeys.serverError.tr,
  //     //     callback: () {
  //     //   Get.back();
  //     // });
  //     loadingIndicator.hide(context);
  //   }
  // }

  RxInt countdown = 60.obs; // Initial countdown time in seconds
  late Timer timer;
  bool isTimerRunning = false;
  void startTimer() {
    if (!isTimerRunning) {
      isTimerRunning = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (countdown > 0) {
          countdown--;
          update();
        } else {
          stopTimer();
        }
      });
    }
  }

  void stopTimer() {
    if (isTimerRunning) {
      isTimerRunning = false;
      timer.cancel();
      // Handle timer completion (e.g., show a "Resend OTP" button)
    }
  }

  // void enableSignUpButton() {
  //   String otp = getOTP();

  //   if (otp.trim().length < 4) {
  //     print("enableSignUpButton +FALSE");
  //     isFormInvalidate.value = false;
  //   } else {
  //     print("enableSignUpButton +FALSE");
  //     isFormInvalidate.value = true;
  //   }

  //   update();
  // }

  void enableButton(
    value,
  ) {
    if (isPassword == true) {
      if (value.trim().length < 6) {
        logcat("CONDITION", "TRUE");
        isFormInvalidate.value = false;
      } else {
        logcat("CONDITION", "FALSE");
        isFormInvalidate.value = true;
      }
      update();
    } else {
      logcat("enableButton", 'FALSE');
      if (value.trim().length < 6) {
        isFormInvalidate.value = false;
      } else {
        isFormInvalidate.value = true;
      }
    }

    update();
  }

  RxBool isFormStartFilling = false.obs;

  RxBool isFormInvalidate = false.obs;

  void clearFocuseNode() {
    fieldOne.clear();
    fieldTwo.clear();
    fieldThree.clear();
    fieldFour.clear();
  }

  void verifyButtonAction(context, id) async {}

  void sendOTP(context, String param, {String countryCode = ""}) async {}

  void verifyOTP(context, String id, String otp, String uniqueId) async {}

  void hideKeyboard(dynamic context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // void getForgotOtp(context, String mobile) async {
  //   //verifyUserPhoneNumber(context);
  //   // return;

  //   var loadingIndicator = LoadingProgressDialog();
  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, LocalizationKeys.noConnection.tr,
  //           callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     loadingIndicator.show(context, '');

  //     var response = await Repository.post({
  //       "MobileNumber": mobile.toString().trim(),
  //     }, ApiUrl.getForgototp);
  //     loadingIndicator.hide(context);
  //     var data = jsonDecode(response.body);
  //     countdown = 60.obs;
  //     startTimer();
  //     if (response.statusCode == 200) {
  //       if (data['status'] == true) {
  //         // showDialogForScreen(context, data['otp'].toString(), callback: () {
  //         //   FocusScope.of(context).requestFocus(otpNode);
  //         //   // clearFocuseNode();
  //         //   otpController.text = "";
  //         // });
  //         otpController.text = "";
  //       } else {
  //         showDialogForScreen(context, data['message'], callback: () {});
  //       }
  //     } else {
  //       logcat("isnotDone", data['message']);
  //       states.value = ScreenState.apiError;
  //       showDialogForScreen(context, data['message'], callback: () {
  //         otpController.text = "";
  //         startTimer();
  //         //Get.back();
  //       });
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, LocalizationKeys.serverError.tr,
  //         callback: () {
  //       Get.back();
  //     });
  //   }
  // }

  showDialogForScreen(context, String message, bool? isEdit,
      {Function? callback}) {
    showMessage(
        context: context,
        callback: () {
          if (callback != null) {
            callback();
          }
          return true;
        },
        message: message,
        title: isEdit == true
            ? ScreenTitle.updateCustomer
            : ScreenTitle.addCustomer,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  var receivedID = '';
  RxBool otpFieldVisibility = false.obs;
  // void verifyUserPhoneNumber(BuildContext context) {
  //   logcat("Mobile", '+91$mobileNo');
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, '');
  //   try {
  //     auth.verifyPhoneNumber(
  //       phoneNumber: "+91 $mobileNo",
  //       timeout: const Duration(minutes: 1),
  //       forceResendingToken: 1,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         loadingIndicator.hide(context);
  //         await auth.signInWithCredential(credential).then(
  //           (value) {
  //             isPassword == true
  //                 ? Get.to(ResetPassScreen(
  //                     fromProfile: false,
  //                     mobile: mobileNo,
  //                   ))
  //                 : Get.to(SignUpInfoScreen(
  //                     mobile: mobileNo,
  //                   ));
  //           },
  //         );
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         logcat("verificationFailed", e.message);
  //         loadingIndicator.hide(context);

  //         if (e.code == 'invalid-phone-number') {
  //           showDialogForScreen(
  //               context, "The provided phone number is not valid.",
  //               callback: () {
  //             otpController.text = "";
  //             startTimer();
  //           });
  //           //Get.snackbar('Error', 'The provided phone number is not valid.');
  //         } else {
  //           showDialogForScreen(context, e.message.toString(), callback: () {
  //             otpController.text = "";
  //             startTimer();
  //           });
  //           //  Get.snackbar('Error', e.message.toString());
  //         }
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         loadingIndicator.hide(context);
  //         logcat("codeSent", 'DONE');
  //         logcat("verificationId", verificationId);
  //         receivedID = verificationId;
  //         otpFieldVisibility.value = true;
  //         update();
  //         startTimer();
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         //loadingIndicator.hide(context);
  //         // showDialogForScreen(context, "TimeOut", callback: () {
  //         //   otpController.text = "";
  //         //   startTimer();
  //         // });
  //         logcat("codeAutoRetrievalTimeout", 'TimeOut');
  //       },
  //     );
  //   } catch (e) {
  //     logcat("verificationId", e.toString());
  //     loadingIndicator.hide(context);
  //   }
  // }

  // Future<void> verifyOTPCode(BuildContext context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, '');

  //   Completer<void> completer = Completer<void>();
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: receivedID,
  //       smsCode: otpController.text.toString(),
  //     );

  //     loadingIndicator.hide(context);
  //     await auth.signInWithCredential(credential).then((value) {
  //       completer.complete();
  //       Get.to(SignUpInfoScreen(
  //         mobile: mobileNo,
  //       ));
  //     });
  //   } catch (e) {
  //     logcat("verifyOTPCode", 'DONE');
  //     logcat("Error signing in with phone number:", e);
  //     if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
  //       showDialogForScreen(context, "Invalid OTP. Please try again.",
  //           callback: () {
  //         otpController.text = "";
  //         startTimer();
  //       });
  //     }
  //     loadingIndicator.hide(context);
  //     completer.completeError(e);
  //   }
  //   await completer.future;
  // }
}
