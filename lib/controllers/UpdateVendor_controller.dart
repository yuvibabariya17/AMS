import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../Config/apicall_constant.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;

class UpdateVendorController extends GetxController {
  late final GetStorage _getStorage;
  final InternetController networkManager = Get.find<InternetController>();

  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  late FocusNode VendornameNode,
      CompanynameNode,
      CompanyAddressNode,
      EmailNode,
      PassNode,
      ContactpernameNode,
      Contact_oneNode,
      Contact_twoNode,
      WhatsappNode,
      LogoNode,
      BreachersNode,
      ProfileNode,
      PropertyNode;

  late TextEditingController Vendornamectr,
      companyctr,
      addressctr,
      emailctr,
      passctr,
      contactpernamectr,
      contact_onectr,
      contact_twoctr,
      whatsappctr,
      logoctr,
      breacherctr,
      profilectr,
      propertyctr;

  final formKey = GlobalKey<FormState>();
  RxBool obsecureText = true.obs;
  RxString fullName = ''.obs;
  RxString mobile = ''.obs;
  RxString address = ''.obs;
  RxString companyname = ''.obs;
  RxString Whatsapp = ''.obs;

  @override
  void onInit() {
    _getStorage = GetStorage();

    VendornameNode = FocusNode();
    CompanynameNode = FocusNode();
    CompanyAddressNode = FocusNode();
    EmailNode = FocusNode();
    PassNode = FocusNode();
    ContactpernameNode = FocusNode();
    Contact_oneNode = FocusNode();
    Contact_twoNode = FocusNode();
    WhatsappNode = FocusNode();
    LogoNode = FocusNode();
    BreachersNode = FocusNode();
    ProfileNode = FocusNode();
    PropertyNode = FocusNode();

    emailctr = TextEditingController();
    passctr = TextEditingController();
    Vendornamectr = TextEditingController();
    companyctr = TextEditingController();
    addressctr = TextEditingController();
    contactpernamectr = TextEditingController();
    contact_onectr = TextEditingController();
    contact_twoctr = TextEditingController();
    whatsappctr = TextEditingController();
    logoctr = TextEditingController();
    breacherctr = TextEditingController();
    profilectr = TextEditingController();
    propertyctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var passModel = ValidationModel(null, null, isValidate: false).obs;
  var vendornameModel = ValidationModel(null, null, isValidate: false).obs;
  var companyModel = ValidationModel(null, null, isValidate: false).obs;
  var addressModel = ValidationModel(null, null, isValidate: false).obs;
  var emailModel = ValidationModel(null, null, isValidate: false).obs;
  var contactnameModel = ValidationModel(null, null, isValidate: false).obs;
  var contactoneModel = ValidationModel(null, null, isValidate: false).obs;
  var contacttwoModel = ValidationModel(null, null, isValidate: false).obs;
  var whatsappModel = ValidationModel(null, null, isValidate: false).obs;
  var logoModel = ValidationModel(null, null, isValidate: false).obs;
  var breacherModel = ValidationModel(null, null, isValidate: false).obs;
  var profileModel = ValidationModel(null, null, isValidate: false).obs;
  var propertyModel = ValidationModel(null, null, isValidate: false).obs;

  void validateVendorname(String? val) {
    vendornameModel.update((model) {
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

  void validateEmail(String? val) {
    emailModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Email Id";
        model.isValidate = false;
      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailctr.text.trim())) {
        model!.error = "Enter Valid Email Id";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  void validatePass(String? val) {
    passModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Password";
        model.isValidate = false;
      } else if (val.replaceAll(' ', '').length < 10) {
        model!.error = "Enter Valid Password";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });
    enableSignUpButton();
  }

  void validateAddressname(String? val) {
    addressModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Company Address";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateCompanyname(String? val) {
    companyModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Company Name";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePhone1(String? val) {
    contactoneModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No.1";
        model.isValidate = false;
      } else if (val.toString().trim()!.replaceAll(' ', '').length != 10) {
        model!.error = "Enter Valid Contact No";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePhone2(String? val) {
    contacttwoModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Contact No.2";
        model.isValidate = false;
      } else if (val.toString().trim()!.replaceAll(' ', '').length != 10) {
        model!.error = "Enter Valid Contact No";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validatePhone3(String? val) {
    whatsappModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Enter Whatsapp No";
        model.isValidate = false;
      } else if (val.toString().trim()!.replaceAll(' ', '').length != 10) {
        model!.error = "Enter Valid Contact No";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateLogo(String? val) {
    logoModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Logo";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateBreacher(String? val) {
    breacherModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Breachers";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProfile(String? val) {
    profileModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Profile Pic";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProperty(String? val) {
    propertyModel.update((model) {
      if (val == null || val.isEmpty) {
        model!.error = "Select Property Images";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void enableSignUpButton() {
    if (vendornameModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (companyModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (addressModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (emailModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (passModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    }
  }

  RxBool isFormInvalidate = false.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;
  RxString uploadProfileId = ''.obs;
  RxString uploadPropertyId = ''.obs;

  void getImageApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadLogo.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadLogo.value != null
              ? http.MultipartFile(
                  'file',
                  uploadLogo.value!.readAsBytes().asStream(),
                  uploadLogo.value!.lengthSync(),
                  filename: uploadLogo.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadImageId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void getBreacher(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadBreachers.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadBreachers.value != null
              ? http.MultipartFile(
                  'file',
                  uploadBreachers.value!.readAsBytes().asStream(),
                  uploadBreachers.value!.lengthSync(),
                  filename: uploadBreachers.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadBreacherId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void getProfile(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadProfile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadProfile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadProfile.value!.readAsBytes().asStream(),
                  uploadProfile.value!.lengthSync(),
                  filename: uploadProfile.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadProfileId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void getProperty(context) async {
    var loadingIndicator = LoadingProgressDialog();
    loadingIndicator.show(context, '');

    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.multiPartPost({
        "file": uploadProperty.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadProperty.value != null
              ? http.MultipartFile(
                  'file',
                  uploadProperty.value!.readAsBytes().asStream(),
                  uploadProperty.value!.lengthSync(),
                  filename: uploadProperty.value!.path.split('/').last,
                )
              : null,
          allowHeader: true);
      var responseDetail = await response.stream.toBytes();
      loadingIndicator.hide(context);

      var result = String.fromCharCodes(responseDetail);
      var json = jsonDecode(result);
      var responseData = UploadImageModel.fromJson(json);
      if (response.statusCode == 200) {
        logcat("responseData", jsonEncode(responseData));
        if (responseData.status == "True") {
          logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
          uploadPropertyId.value = responseData.data.id.toString();
        } else {
          showDialogForScreen(context, responseData.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, responseData.message.toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
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
        title: ScreenTitle.updateVendor,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  Rx<File?> uploadLogo = null.obs;
  Rx<File?> uploadBreachers = null.obs;
  Rx<File?> uploadProfile = null.obs;
  Rx<File?> uploadProperty = null.obs;

  actionClickUploadImage(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadLogo = File(file.path).obs;
          logoctr.text = file.name;
          validateLogo(logoctr.text);
          getImageApi(context);
        }
      }
    });

    update();
  }

  actionClickUploadBreachers(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadBreachers = File(file.path).obs;
          breacherctr.text = file.name;
          validateBreacher(breacherctr.text);
          getBreacher(context);
        }
      }
    });

    update();
  }

  actionClickUploadProfile(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadProfile = File(file.path).obs;
          profilectr.text = file.name;
          validateProfile(profilectr.text);
          getProfile(context);
          // UploadProperty(
          //   context,
          //   false,
          //   multipleImage: true,
          // );
        }
      }
    });

    update();
  }

  actionClickUploadProperty(context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        if (file != null) {
          uploadProperty = File(file.path).obs;
          propertyctr.text = file.name;
          validateProperty(propertyctr.text);
          getProperty(context);
        }
      }
    });

    update();
  }

  RxList<File> uploadMorePrescriptionFile = <File>[].obs;
  Rx<File?> uploadPrescriptionFile = null.obs;
  late TextEditingController addMorePresctr = TextEditingController();
  late FocusNode addMorePresNode;
  var addMorePresModel = ValidationModel(null, null, isValidate: false).obs;

  actionClickUploadImageFromCamera(context, isUpload,
      {bool? isCamera, bool multipleImage = false}) async {
    if (multipleImage) {
      uploadMorePrescriptionFile.clear();
      update();
      await ImagePicker()
          .pickMultiImage(maxWidth: 1080, maxHeight: 1080, imageQuality: 100)
          .then((file) async {
        if (file.isNotEmpty) {
          for (var f in file) {
            uploadMorePrescriptionFile.value.add(File(f.path));
          }
          propertyctr.text =
              "${uploadMorePrescriptionFile.length} file selected";
          validateProperty(propertyctr.text);
        }
      });
      return;
    }
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        // CroppedFile? croppedFile = await ImageCropper().cropImage(
        //     sourcePath: file.path,
        //     maxWidth: 1080,
        //     maxHeight: 1080,
        //     cropStyle: CropStyle.,
        //     aspectRatioPresets: Platform.isAndroid
        //         ? [
        //             CropAspectRatioPreset.square,
        //             CropAspectRatioPreset.ratio3x2,
        //             CropAspectRatioPreset.original,
        //             CropAspectRatioPreset.ratio4x3,
        //             CropAspectRatioPreset.ratio16x9
        //           ]
        //         : [
        //             CropAspectRatioPreset.original,
        //             CropAspectRatioPreset.square,
        //             CropAspectRatioPreset.ratio3x2,
        //             CropAspectRatioPreset.ratio4x3,
        //             CropAspectRatioPreset.ratio5x3,
        //             CropAspectRatioPreset.ratio5x4,
        //             CropAspectRatioPreset.ratio7x5,
        //             CropAspectRatioPreset.ratio16x9
        //           ],
        //     uiSettings: [
        //       AndroidUiSettings(
        //           toolbarTitle: 'Crop Image',
        //           cropGridColor: primaryColor,
        //           toolbarColor: primaryColor,
        //           statusBarColor: primaryColor,
        //           toolbarWidgetColor: white,
        //           activeControlsWidgetColor: primaryColor,
        //           initAspectRatio: CropAspectRatioPreset.original,
        //           lockAspectRatio: false),
        //       IOSUiSettings(
        //         title: 'Crop Image',
        //         cancelButtonTitle: 'Cancel',
        //         doneButtonTitle: 'Done',
        //         aspectRatioLockEnabled: false,
        //       ),
        //     ],
        //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        isUpload ? uploadPrescriptionFile = File(file.path).obs : "";
        // avatarFile.value!.path.split('/').last;
        isUpload
            ? propertyctr.text = file.name
            : addMorePresctr.text = file.name;
        validateProperty(propertyctr.text);
      }
    });
    update();
  }

  // UploadProperty(context, isUpload, {bool multipleImage = false}) async {
  //   if (multipleImage) {
  //     propertyctr.clear();
  //     update();
  //     await ImagePicker()
  //         .pickMultiImage(maxWidth: 1080, maxHeight: 1080, imageQuality: 100)
  //         .then((file) async {
  //       if (file.isNotEmpty) {
  //         for (var f in file) {
  //           propertyctr.value = (File(f.path));
  //         }
  //         propertyctr.text = "${uploadProperty.length} file selected";
  //         validateProperty(propertyctr.text);
  //       }
  //     });
  //     return;
  //   }
  //   await ImagePicker()
  //       .pickImage(
  //           //source: ImageSource.gallery,
  //           source: ImageSource.gallery,
  //           maxWidth: 1080,
  //           maxHeight: 1080,
  //           imageQuality: 100)
  //       .then((file) async {});

  //   update();
  // }

  actionClickUploadImageForLogo(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            maxWidth: 1080,
            maxHeight: 1080,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Image',
                  cropGridColor: primaryColor,
                  toolbarColor: primaryColor,
                  statusBarColor: primaryColor,
                  toolbarWidgetColor: white,
                  activeControlsWidgetColor: primaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Image',
                cancelButtonTitle: 'Cancel',
                doneButtonTitle: 'Done',
                aspectRatioLockEnabled: false,
              ),
            ],
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (file != null) {
          uploadLogo = File(file.path).obs;
          logoctr.text = file.name;
          validateLogo(logoctr.text);
          getImageApi(context);
        }

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }

  actionClickUploadImageForBreachers(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            maxWidth: 1080,
            maxHeight: 1080,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Image',
                  cropGridColor: primaryColor,
                  toolbarColor: primaryColor,
                  statusBarColor: primaryColor,
                  toolbarWidgetColor: white,
                  activeControlsWidgetColor: primaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Image',
                cancelButtonTitle: 'Cancel',
                doneButtonTitle: 'Done',
                aspectRatioLockEnabled: false,
              ),
            ],
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (file != null) {
          uploadBreachers = File(file.path).obs;
          breacherctr.text = file.name;
          validateBreacher(breacherctr.text);
          getBreacher(context);
        }

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }

  actionClickUploadImageForProfile(context, {bool? isCamera}) async {
    await ImagePicker()
        .pickImage(
            //source: ImageSource.gallery,
            source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
            maxWidth: 1080,
            maxHeight: 1080,
            imageQuality: 100)
        .then((file) async {
      if (file != null) {
        //Cropping the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: file.path,
            maxWidth: 1080,
            maxHeight: 1080,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: Platform.isAndroid
                ? [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ]
                : [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio5x3,
                    CropAspectRatioPreset.ratio5x4,
                    CropAspectRatioPreset.ratio7x5,
                    CropAspectRatioPreset.ratio16x9
                  ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Crop Image',
                  cropGridColor: primaryColor,
                  toolbarColor: primaryColor,
                  statusBarColor: primaryColor,
                  toolbarWidgetColor: white,
                  activeControlsWidgetColor: primaryColor,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Crop Image',
                cancelButtonTitle: 'Cancel',
                doneButtonTitle: 'Done',
                aspectRatioLockEnabled: false,
              ),
            ],
            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
        if (file != null) {
          uploadProfile = File(file.path).obs;
          profilectr.text = file.name;
          validateProfile(profilectr.text);
          getProfile(context);
        }

        // if (croppedFile != null) {
        //   uploadImageFile = File(croppedFile.path).obs;
        //   profilePic.value = croppedFile.path;
        //   update();
        // }
      }
    });

    update();
  }

  // actionClickUploadImageForProperty(context, {bool? isCamera}) async {
  //   await ImagePicker()
  //       .pickImage(
  //           //source: ImageSource.gallery,
  //           source: isCamera == true ? ImageSource.camera : ImageSource.gallery,
  //           maxWidth: 1080,
  //           maxHeight: 1080,
  //           imageQuality: 100)
  //       .then((file) async {
  //     if (file != null) {
  //       //Cropping the image
  //       CroppedFile? croppedFile = await ImageCropper().cropImage(
  //           sourcePath: file.path,
  //           maxWidth: 1080,
  //           maxHeight: 1080,
  //           cropStyle: CropStyle.rectangle,
  //           aspectRatioPresets: Platform.isAndroid
  //               ? [
  //                   CropAspectRatioPreset.square,
  //                   CropAspectRatioPreset.ratio3x2,
  //                   CropAspectRatioPreset.original,
  //                   CropAspectRatioPreset.ratio4x3,
  //                   CropAspectRatioPreset.ratio16x9
  //                 ]
  //               : [
  //                   CropAspectRatioPreset.original,
  //                   CropAspectRatioPreset.square,
  //                   CropAspectRatioPreset.ratio3x2,
  //                   CropAspectRatioPreset.ratio4x3,
  //                   CropAspectRatioPreset.ratio5x3,
  //                   CropAspectRatioPreset.ratio5x4,
  //                   CropAspectRatioPreset.ratio7x5,
  //                   CropAspectRatioPreset.ratio16x9
  //                 ],
  //           uiSettings: [
  //             AndroidUiSettings(
  //                 toolbarTitle: 'Crop Image',
  //                 cropGridColor: primaryColor,
  //                 toolbarColor: primaryColor,
  //                 statusBarColor: primaryColor,
  //                 toolbarWidgetColor: white,
  //                 activeControlsWidgetColor: primaryColor,
  //                 initAspectRatio: CropAspectRatioPreset.original,
  //                 lockAspectRatio: false),
  //             IOSUiSettings(
  //               title: 'Crop Image',
  //               cancelButtonTitle: 'Cancel',
  //               doneButtonTitle: 'Done',
  //               aspectRatioLockEnabled: false,
  //             ),
  //           ],
  //           aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
  //       if (file != null) {
  //         uploadProperty = File(file.path).obs;
  //         propertyctr.text = file.name;
  //         validateProperty(propertyctr.text);
  //         getProperty(context);
  //         UploadProperty(
  //           context,
  //           false,
  //           multipleImage: true,
  //         );
  //       }
  //       // if (croppedFile != null) {
  //       //   uploadImageFile = File(croppedFile.path).obs;
  //       //   profilePic.value = croppedFile.path;
  //       //   update();
  //       // }
  //     }
  //   });

  //   update();
  // }
}
