import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Config/apicall_constant.dart';
import '../core/utils/log.dart';
import '../preference/UserPreference.dart';

class Repository {
  static final client = http.Client();

  static Uri buildUrl(String endPoint) {
    String host = ApiUrl.buildApiUrl;
    final apiPath = host + endPoint;
    logcat("API", apiPath);
    return Uri.parse(apiPath);
  }

  // static Uri buildUrl(String endPoint, String ip) {
  //   // String host = ApiUrl.buildApiUrl;
  //   //final apiPath = host + endPoint
  //   final apiPath = ip + endPoint;
  //   logcat("API", apiPath);
  //   return Uri.parse(apiPath);
  // }

  static get buildHeader async {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }

  static get buildMultipartHeader async {
    return {
      'content-type': "multipart/form-data",
    };
  }

  static Future<http.Response> delete(
      Map<String, dynamic> body, String endPoint,
      {bool? allowHeader, int? itemId}) async {
    String ip = await UserPreferences().getIP();
    //  logcat("APIURL:::", buildUrl(endPoint, ip));
    String token = await UserPreferences().getToken();
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      'x-access-token': token,
    };

    var response = await client.delete(
      itemId != null ? buildUrl('$endPoint/$itemId') : buildUrl(endPoint),
      headers: allowHeader == true ? headers : await buildHeader,
    );
    return response;
  }

  static Future<http.Response> put(Map<String, dynamic> body, String endPoint,
      {bool? allowHeader}) async {
    String ip = await UserPreferences().getIP();
    logcat(
        "APIURL:::",
        buildUrl(
          endPoint,
        ));
    String token = await UserPreferences().getToken();
    logcat("TOKEN", token.toString());
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'x-access-token': token,
    };
    logcat("PassignData", {
      'Content-Type': "application/json",
      'Authorization': "Bearer $token",
    });
    var response = await client.put(
        buildUrl(
          endPoint,
        ),
        body: jsonEncode(body),
        headers: allowHeader == true ? headers : await buildHeader);
    return response;
  }

  static Future<http.Response> post(Map<String, dynamic> body, String endPoint,
      {bool? allowHeader}) async {
    String ip = await UserPreferences().getIP();
    logcat(
        "APIURL:::",
        buildUrl(
          endPoint,
        ));
    String token = await UserPreferences().getToken();
    logcat("TOKEN", token.toString());
    Map<String, String> headers = {
      'Content-Type': "application/json",
      'x-access-token': token,
    };
    logcat("PassignData", {
      'Content-Type': "application/json",
      'Authorization': "Bearer $token",
    });
    var response = await client.post(
        buildUrl(
          endPoint,
        ),
        body: jsonEncode(body),
        headers: allowHeader == true ? headers : await buildHeader);
    return response;
  }

  static Future<http.Response> get(Map<String, String> body, String endPoint,
      {bool? allowHeader, bool? list}) async {
    String ip = await UserPreferences().getIP();
    logcat(
        "APIURL:::",
        buildUrl(
          endPoint,
        ));

    var response = await client.get(
        buildUrl(
          endPoint,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
    return response;
  }

  static Future<http.StreamedResponse> multiPartPost(var body, String endPoint,
      {bool allowHeader = false,
      http.MultipartFile? multiPart,
      http.MultipartFile? multiPartData}) async {
    String token = await UserPreferences().getToken();
    Map<String, String> headers = {
      'Content-Type': "multipart/form-data",
      'x-access-token': token,
    };

    String ip = await UserPreferences().getIP();
    var request = http.MultipartRequest(
      "POST",
      buildUrl(
        endPoint,
      ),
    );
    if (allowHeader) request.headers.addAll(headers);
    logcat("multiPart", multiPart.toString());
    if (multiPart != null) {
      request.files.add(multiPart);
      logcat("FILE", request.files.length.toString());

      if (multiPartData != null) {
        request.files.add(multiPartData);
      }
    }

    request.fields.addAll(body);
    var response = await request.send();

    return response;
  }
}
