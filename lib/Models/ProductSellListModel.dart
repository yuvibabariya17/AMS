// To parse this JSON data, do
//
//     final productSellListModel = productSellListModelFromJson(jsonString);

import 'dart:convert';

ProductSellListModel productSellListModelFromJson(String str) =>
    ProductSellListModel.fromJson(json.decode(str));

String productSellListModelToJson(ProductSellListModel data) =>
    json.encode(data.toJson());

class ProductSellListModel {
  int status;
  String message;
  List<ProductList> data;
  int totalRecord;
  int totalPages;

  ProductSellListModel({
    required this.status,
    required this.message,
    required this.data,
    required this.totalRecord,
    required this.totalPages,
  });

  factory ProductSellListModel.fromJson(Map<String, dynamic> json) =>
      ProductSellListModel(
        status: json["status"],
        message: json["message"],
        data: List<ProductList>.from(
            json["data"].map((x) => ProductList.fromJson(x))),
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

class ProductList {
  String id;
  String customerId;
  String vendorId;
  int dateOfSale;
  int createdAt;
  CustomerInfo customerInfo;
  VendorInfo vendorInfo;
  List<ProductSaleInfo> productSaleInfo;

  ProductList({
    required this.id,
    required this.customerId,
    required this.vendorId,
    required this.dateOfSale,
    required this.createdAt,
    required this.customerInfo,
    required this.vendorInfo,
    required this.productSaleInfo,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["_id"],
        customerId: json["customer_id"],
        vendorId: json["vendor_id"],
        dateOfSale: json["date_of_sale"],
        createdAt: json["created_at"],
        customerInfo: CustomerInfo.fromJson(json["customer_info"]),
        vendorInfo: VendorInfo.fromJson(json["vendor_info"]),
        productSaleInfo: List<ProductSaleInfo>.from(
            json["product_sale_info"].map((x) => ProductSaleInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer_id": customerId,
        "vendor_id": vendorId,
        "date_of_sale": dateOfSale,
        "created_at": createdAt,
        "customer_info": customerInfo.toJson(),
        "vendor_info": vendorInfo.toJson(),
        "product_sale_info":
            List<dynamic>.from(productSaleInfo.map((x) => x.toJson())),
      };
}

class CustomerInfo {
  String name;
  String contactNo;
  String whatsappNo;
  String email;
  String address;

  CustomerInfo({
    required this.name,
    required this.contactNo,
    required this.whatsappNo,
    required this.email,
    required this.address,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        name: json["name"],
        contactNo: json["contact_no"],
        whatsappNo: json["whatsapp_no"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact_no": contactNo,
        "whatsapp_no": whatsappNo,
        "email": email,
        "address": address,
      };
}

class ProductSaleInfo {
  String id;
  int qty;
  CategoryInfo productCategoryInfo;
  CategoryInfo brandCategoryInfo;
  ProductInfo productInfo;

  ProductSaleInfo({
    required this.id,
    required this.qty,
    required this.productCategoryInfo,
    required this.brandCategoryInfo,
    required this.productInfo,
  });

  factory ProductSaleInfo.fromJson(Map<String, dynamic> json) =>
      ProductSaleInfo(
        id: json["_id"],
        qty: json["qty"],
        productCategoryInfo:
            CategoryInfo.fromJson(json["product_category_info"]),
        brandCategoryInfo: CategoryInfo.fromJson(json["brand_category_info"]),
        productInfo: ProductInfo.fromJson(json["product_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "qty": qty,
        "product_category_info": productCategoryInfo.toJson(),
        "brand_category_info": brandCategoryInfo.toJson(),
        "product_info": productInfo.toJson(),
      };
}

class CategoryInfo {
  String id;
  String name;
  String description;

  CategoryInfo({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
      };
}

class ProductInfo {
  String id;
  String name;
  String uploadId;
  String description;
  int amount;
  int qty;
  UploadInfo uploadInfo;

  ProductInfo({
    required this.id,
    required this.name,
    required this.uploadId,
    required this.description,
    required this.amount,
    required this.qty,
    required this.uploadInfo,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["_id"],
        name: json["name"],
        uploadId: json["upload_id"],
        description: json["description"],
        amount: json["amount"],
        qty: json["qty"],
        uploadInfo: UploadInfo.fromJson(json["upload_info"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "upload_id": uploadId,
        "description": description,
        "amount": amount,
        "qty": qty,
        "upload_info": uploadInfo.toJson(),
      };
}

class UploadInfo {
  String image;

  UploadInfo({
    required this.image,
  });

  factory UploadInfo.fromJson(Map<String, dynamic> json) => UploadInfo(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
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
