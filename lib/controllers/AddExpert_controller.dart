import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/Models/VendorServiceModel.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../Config/apicall_constant.dart';
import '../Models/CommonModel.dart';
import '../Models/sign_in_form_validation.dart';
import '../api_handle/Repository.dart';
import '../core/constants/strings.dart';
import '../core/themes/font_constant.dart';
import '../core/utils/log.dart';
import '../dialogs/dialogs.dart';
import '../dialogs/loading_indicator.dart';
import '../preference/UserPreference.dart';
import 'Appointment_screen_controller.dart';
import 'internet_controller.dart';
import 'package:http/http.dart' as http;

class AddexpertController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode ServiceNode,
      ExpertNode,
      PriceNode,
      ProfileNode,
      StartTimeNode,
      EndTimeNode;

  late TextEditingController Servicectr,
      Expertctr,
      Pricectr,
      Profilectr,
      Startctr,
      Endctr;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    ServiceNode = FocusNode();
    ExpertNode = FocusNode();
    PriceNode = FocusNode();
    ProfileNode = FocusNode();
    StartTimeNode = FocusNode();
    EndTimeNode = FocusNode();

    Servicectr = TextEditingController();
    Expertctr = TextEditingController();
    Pricectr = TextEditingController();
    Profilectr = TextEditingController();
    Startctr = TextEditingController();
    Endctr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  String startTime = "";
  String endTime = "";

  void updateStartTime(date) {
    Startctr.text = date;
    print("PICKED_DATE${Startctr.value}");
    update();
  }

  void updateEndTime(date) {
    Endctr.text = date;
    print("PICKED_DATE${Endctr.value}");
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var Model = ValidationModel(null, null, isValidate: false).obs;
  var ExpertModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;
  var ProfileModel = ValidationModel(null, null, isValidate: false).obs;
  var StartTimeModel = ValidationModel(null, null, isValidate: false).obs;
  var EndTimeModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (Model.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ExpertModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ProfileModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (StartTimeModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (EndTimeModel.value.isValidate == false) {
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
    Model.update((model) {
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

  void validateProfile(String? val) {
    ProfileModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Profile Pic";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateStartTime(String? val) {
    StartTimeModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Time";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateEndTime(String? val) {
    EndTimeModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Time";
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

  void addExpertApi(context) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();
      logcat("EXPERT DETAILS", {
        "name": Expertctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "service_id": ServiceId.value.toString().trim(),
        "image_id": uploadImageId.value.toString(),
        "amount": int.parse(Pricectr.text),
        "startTime": startTime,
        "endTime": endTime
      });

      var response = await Repository.post({
        "name": Expertctr.text.toString().trim(),
        "vendor_id": retrievedObject.id.toString().trim(),
        "service_id": ServiceId.value.toString(),
        "image_id": uploadImageId.value.toString(),
        "amount": int.parse(Pricectr.text),
        "startTime": startTime,
        "endTime": endTime
      }, ApiUrl.addExpert, allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  void UpdateExpert(context, String expertId) async {
    var loadingIndicator = LoadingProgressDialog();
    try {
      if (networkManager.connectionType == 0) {
        loadingIndicator.hide(context);
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      loadingIndicator.show(context, '');
      var retrievedObject = await UserPreferences().getSignInInfo();

      var response = await Repository.put({
        "name": Expertctr.text.toString().trim(),
        "vendor_id": retrievedObject!.id.toString().trim(),
        "service_id": ServiceId.value.toString(),
        "amount": int.parse(Pricectr.text),
      }, '${ApiUrl.editCourse}/$expertId', allowHeader: true);
      loadingIndicator.hide(context);
      var data = jsonDecode(response.body);
      logcat("RESPOSNE", data);
      if (response.statusCode == 200) {
        var responseDetail = CommonModel.fromJson(data);
        if (responseDetail.status == 1) {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {
            Get.back(result: true);
          });
        } else {
          showDialogForScreen(context, responseDetail.message.toString(),
              callback: () {});
        }
      } else {
        state.value = ScreenState.apiError;
        showDialogForScreen(context, data['message'].toString(),
            callback: () {});
      }
    } catch (e) {
      logcat("Exception", e);
      showDialogForScreen(context, Connection.servererror, callback: () {});
      loadingIndicator.hide(context);
    }
  }

  Widget setServiceList() {
    return Obx(() {
      if (isServiceTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isServiceTypeApiList.value);

      return setDropDownTestContent(
        serviceObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: serviceObjectList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              dense: true,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
              horizontalTitleGap: null,
              minLeadingWidth: 5,
              onTap: () {
                Get.back();
                ServiceId.value = serviceObjectList[index].id.toString();
                Servicectr.text = serviceObjectList[index].fees.toString();

                validateServicename(Servicectr.text);
              },
              title: Text(
                serviceObjectList[index].fees.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp),
              ),
            );
          },
        ),
      );
    });
  }

  RxBool isServiceTypeApiList = false.obs;
  RxList<VendorServiceList> serviceObjectList = <VendorServiceList>[].obs;
  RxString ServiceId = "".obs;

  void getServiceList(context) async {
    isServiceTypeApiList.value = true;
    try {
      if (networkManager.connectionType == 0) {
        showDialogForScreen(context, Connection.noConnection, callback: () {
          Get.back();
        });
        return;
      }
      var response = await Repository.post({}, ApiUrl.vendorServiceList,
          allowHeader: true);
      isServiceTypeApiList.value = false;
      var responseData = jsonDecode(response.body);
      logcat("SERVICE LIST", jsonEncode(responseData));

      if (response.statusCode == 200) {
        var data = VendorServiceModel.fromJson(responseData);
        if (data.status == 1) {
          serviceObjectList.clear();
          serviceObjectList.addAll(data.data);

          logcat("SERVICE LIST", jsonEncode(serviceObjectList));
        } else {
          showDialogForScreen(context, responseData['message'],
              callback: () {});
        }
      } else {
        showDialogForScreen(context, Connection.servererror, callback: () {});
      }
    } catch (e) {
      logcat('Exception', e);
      isServiceTypeApiList.value = false;
    }
  }

  // RxBool isServiceTypeApiList = false.obs;
  // RxList<ServiceList> serviceObjectList = <ServiceList>[].obs;
  RxString serviceId = "".obs;
  RxString uploadImageId = ''.obs;

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
        title: ScreenTitle.addExpert,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

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
        "file": uploadImageFile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadImageFile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadImageFile.value!.readAsBytes().asStream(),
                  uploadImageFile.value!.lengthSync(),
                  filename: uploadImageFile.value!.path.split('/').last,
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

  Rx<File?> uploadImageFile = null.obs;

  actionClickUploadImageFromCamera(context, {bool? isCamera}) async {
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
          uploadImageFile = File(file.path).obs;
          Profilectr.text = file.name;
          validateProfile(Profilectr.text);
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




}
