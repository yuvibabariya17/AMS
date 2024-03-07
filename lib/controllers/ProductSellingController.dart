import 'dart:convert';
import 'dart:io';
import 'package:booking_app/Config/apicall_constant.dart';
import 'package:booking_app/Models/CustomerListModel.dart';
import 'package:booking_app/Models/UploadImageModel.dart';
import 'package:booking_app/Models/sign_in_form_validation.dart';
import 'package:booking_app/api_handle/Repository.dart';
import 'package:booking_app/controllers/home_screen_controller.dart';
import 'package:booking_app/controllers/internet_controller.dart';
import 'package:booking_app/core/constants/strings.dart';
import 'package:booking_app/core/themes/color_const.dart';
import 'package:booking_app/core/themes/font_constant.dart';
import 'package:booking_app/core/utils/helper.dart';
import 'package:booking_app/core/utils/log.dart';
import 'package:booking_app/dialogs/dialogs.dart';
import 'package:booking_app/dialogs/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class ProductSellingController extends GetxController {
  final InternetController networkManager = Get.find<InternetController>();

  late FocusNode studentNode,
      courseNode,
      emailNode,
      notesNode,
      imageNode,
      orderNode,
      productCatNode,
      brandNode,
      productNameNode,
      qtyNode,
      priceNode,
      customerNode,
      feesNode;

  Rx<File?> avatarFile = null.obs;
  Rx<File?> videoFile = null.obs;
  Rx<ScreenState> state = ScreenState.apiLoading.obs;

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late TextEditingController studentctr,
      coursectr,
      emailctr,
      notesctr,
      imgctr,
      Feesctr,
      orderDatectr,
      productCatctr,
      brandctr,
      productNamectr,
      qtyctr,
      customerctr,
      pricectr;
  // endTimectr

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    studentNode = FocusNode();
    imageNode = FocusNode();
    courseNode = FocusNode();
    emailNode = FocusNode();
    notesNode = FocusNode();
    feesNode = FocusNode();
    orderNode = FocusNode();
    productCatNode = FocusNode();
    brandNode = FocusNode();
    productNameNode = FocusNode();
    customerNode = FocusNode();

    qtyNode = FocusNode();
    priceNode = FocusNode();

    studentctr = TextEditingController();
    imgctr = TextEditingController();
    coursectr = TextEditingController();
    emailctr = TextEditingController();
    notesctr = TextEditingController();
    Feesctr = TextEditingController();
    orderDatectr = TextEditingController();
    pricectr = TextEditingController();
    qtyctr = TextEditingController();
    productNamectr = TextEditingController();
    brandctr = TextEditingController();
    productCatctr = TextEditingController();
    customerctr = TextEditingController();

    // endTimectr = TextEditingController();

    enableSignUpButton();
    super.onInit();
  }

  void updateDate(date) {
    orderDatectr.text = date;
    update();
  }

  var isLoading = false.obs;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var StudentModel = ValidationModel(null, null, isValidate: false).obs;
  var ImageModel = ValidationModel(null, null, isValidate: false).obs;
  var FeesModel = ValidationModel(null, null, isValidate: false).obs;
  var ProductModel = ValidationModel(null, null, isValidate: false).obs;
  var NotesModel = ValidationModel(null, null, isValidate: false).obs;
  var OrderDateModel = ValidationModel(null, null, isValidate: false).obs;
  var ProductcatModel = ValidationModel(null, null, isValidate: false).obs;
  var BrandModel = ValidationModel(null, null, isValidate: false).obs;
  var NameModel = ValidationModel(null, null, isValidate: false).obs;
  var QtyModel = ValidationModel(null, null, isValidate: false).obs;
  var PriceModel = ValidationModel(null, null, isValidate: false).obs;
  var CustomerModel = ValidationModel(null, null, isValidate: false).obs;

  void enableSignUpButton() {
    if (StudentModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ImageModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (FeesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (ProductModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (NotesModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (OrderDateModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    } else if (CustomerModel.value.isValidate == false) {
      isFormInvalidate.value = false;
    }
    else {
      isFormInvalidate.value = true;
    }
  }

  void validateStudent(String? val) {
    StudentModel.update((model) {
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

  
  void validateCustomer(String? val) {
    StudentModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Customer";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateImage(String? val) {
    ImageModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Select Image";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateFees(String? val) {
    FeesModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Address";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProduct(String? val) {
    ProductModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Email";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateNotes(String? val) {
    NotesModel.update((model) {
      if (val != null && val.isEmpty) {
        model!.error = "Enter Contact Number";
        model.isValidate = false;
      } else {
        model!.error = null;
        model.isValidate = true;
      }
    });

    enableSignUpButton();
  }

  void validateProductDate(String? val) {
    OrderDateModel.update((model) {
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

  RxBool isFormInvalidate = false.obs;
  RxString uploadImageId = ''.obs;
  RxString uploadBreacherId = ''.obs;

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


 RxBool isCustomerTypeApiList = false.obs;
  RxList<ListofCustomer> customerObjectList = <ListofCustomer>[].obs;
  RxString customerId = "".obs;


   void getCustomerList(context) async {
    state.value = ScreenState.apiLoading;
    isCustomerTypeApiList.value = true;
    // try {
    if (networkManager.connectionType == 0) {
      showDialogForScreen(context, Connection.noConnection, callback: () {
        Get.back();
      });
      return;
    }
    var response =
        await Repository.post({}, ApiUrl.customerList, allowHeader: true);
    isCustomerTypeApiList.value = false;
    var responseData = jsonDecode(response.body);
    logcat(" CUSTOMER RESPONSE", jsonEncode(responseData));

    if (response.statusCode == 200) {
      var data = CustomerListModel.fromJson(responseData);
      if (data.status == 1) {
        state.value = ScreenState.apiSuccess;
        customerObjectList.clear();
        customerObjectList.addAll(data.data);
        logcat("CUSTOMER RESPONSE", jsonEncode(customerObjectList));
      } else {
        showDialogForScreen(context, responseData['message'], callback: () {});
      }
    } else {
      showDialogForScreen(context, Connection.servererror, callback: () {});
    }
    // } catch (e) {
    //   logcat('Exception', e);
    //   isCourseTypeApiList.value = false;
    // }
  }


   Widget setCustomerList() {
    return Obx(() {
      if (isCustomerTypeApiList.value == true)
        return setDropDownContent([].obs, Text("Loading"),
            isApiIsLoading: isCustomerTypeApiList.value);

      return setDropDownTestContent(
        customerObjectList,
        ListView.builder(
          shrinkWrap: true,
          itemCount: customerObjectList.length,
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
                logcat("ONTAP", "SACHIN");
                customerId.value =
                    customerObjectList[index].name.toString();
                coursectr.text =
                    customerObjectList[index].name.capitalize.toString();

              //  validateStudent(val);
              },
              title: Text(
                customerObjectList[index].name.toString(),
                style: TextStyle(fontFamily: fontRegular, fontSize: 13.5.sp,  color: isDarkMode() ? white : black),
              ),
            );
          },
        ),
      );
    });
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
        title: ScreenTitle.reportBug,
        negativeButton: '',
        positiveButton: CommonConstant.continuebtn);
  }

  void getImage(context) async {
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
        "file": uploadReportFile.value!.path.split('/').last,
      }, ApiUrl.uploadImage,
          multiPart: uploadReportFile.value != null
              ? http.MultipartFile(
                  'file',
                  uploadReportFile.value!.readAsBytes().asStream(),
                  uploadReportFile.value!.lengthSync(),
                  filename: uploadReportFile.value!.path.split('/').last,
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



  // void getVideo(context) async {
  //   var loadingIndicator = LoadingProgressDialog();
  //   loadingIndicator.show(context, '');

  //   try {
  //     if (networkManager.connectionType == 0) {
  //       loadingIndicator.hide(context);
  //       showDialogForScreen(context, Connection.noConnection, callback: () {
  //         Get.back();
  //       });
  //       return;
  //     }
  //     var response = await Repository.multiPartPost({
  //       "file": uploadVideoFile.value!.path.split('/').last,
  //     }, ApiUrl.uploadImage,
  //         multiPart: uploadVideoFile.value != null
  //             ? http.MultipartFile(
  //                 'file',
  //                 uploadVideoFile.value!.readAsBytes().asStream(),
  //                 uploadVideoFile.value!.lengthSync(),
  //                 filename: uploadVideoFile.value!.path.split('/').last,
  //               )
  //             : null,
  //         allowHeader: true);
  //     var responseDetail = await response.stream.toBytes();
  //     loadingIndicator.hide(context);

  //     var result = String.fromCharCodes(responseDetail);
  //     var json = jsonDecode(result);
  //     var responseData = UploadImageModel.fromJson(json);
  //     if (response.statusCode == 200) {
  //       logcat("responseData", jsonEncode(responseData));
  //       if (responseData.status == "True") {
  //         logcat("UPLOAD_IMAGE_ID", responseData.data.id.toString());
  //         uploadBreacherId.value = responseData.data.id.toString();
  //       } else {
  //         showDialogForScreen(context, responseData.message.toString(),
  //             callback: () {});
  //       }
  //     } else {
  //       state.value = ScreenState.apiError;
  //       showDialogForScreen(context, responseData.message.toString(),
  //           callback: () {});
  //     }
  //   } catch (e) {
  //     logcat("Exception", e);
  //     showDialogForScreen(context, Connection.servererror, callback: () {});
  //     loadingIndicator.hide(context);
  //   }
  // }

  actionClickUploadImage(context, {bool? isCamera}) async {
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
          uploadReportFile = File(file.path).obs;
          imgctr.text = file.name;
          validateImage(imgctr.text);
          getImage(context);
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

  Rx<File?> uploadReportFile = null.obs;
  Rx<File?> uploadVideoFile = null.obs;
}
