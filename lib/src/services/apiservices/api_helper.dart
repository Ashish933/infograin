import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:slice_ledger/src/views/signup_screen.dart';

import '../../../session/session.dart';
import '../../utils/fonts.dart';
import 'api_header.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class ApiHelper {
  // post api request without Encode
  static Future<Response> postWithoutEncodeCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    var url = Uri.parse(path);
    final result =
    await post(url, headers: ApiHeader.header(), body: parameters);
    if (kDebugMode) {
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);
    return result;
  }

  // post api request without Encode
  static Future<Response> postWithoutTokenCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    var url = Uri.parse(path);
    final result =
    await post(url, headers: ApiHeader.header(), body: jsonEncode(parameters));
    if (kDebugMode) {
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);
    return result;
  }

  static Future<Response> postWithTokenCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    var url = Uri.parse(path);
    final result =
    await post(url, headers: ApiHeader.tokenWithContentTypeHeader(),
        body: jsonEncode(parameters));
    if (kDebugMode) {
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);
    return result;
  }


  // post api request wideout Encode token
  static Future<Response> postWideoutEncodeToken(
      {required String path, required Map<String, dynamic> parameters}) async {
    // String token = await Session.token() ?? "";
    // log(token);

    var url = Uri.parse(path);
    final result =
    await post(url, headers: ApiHeader.header(), body: jsonEncode(parameters));
    if (kDebugMode) {
      // SACHiN
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("STATUS => ${result.statusCode}");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);

    return result;
  }

  // post api request with token
  static Future<Response> postEncodeCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    // String token = Session.token() ?? "";
    parameters.removeWhere((key, value) => value == null);
    final result = await post(Uri.parse(path),
        headers: ApiHeader.tokenHeader(),
        // encoding: Encoding.getByName("utf-8"),
        body: jsonEncode(parameters));
    if (kDebugMode) {
      // SACHiN
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("STATUS => ${result.statusCode}");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("HEADERS => ${ApiHeader.tokenHeader()} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);

    return result;
  }

  // put api request with token
  static Future<Response> putEncodeCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    final result = await put(Uri.parse(path),
        headers: ApiHeader.tokenHeader(),
        // encoding: Encoding.getByName("utf-8"),
        body: jsonEncode(parameters));
    if (kDebugMode) {
      // SACHiN
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("TYPE => PUT");
      log("STATUS => ${result.statusCode}");
      log("REQUEST => ${jsonEncode(parameters)} ");
      log("HEADERS => ${ApiHeader.tokenHeader()} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);

    return result;
  }

  // delete api request with token
  static Future<Response> deleteEncodeCall({required String path, id}) async {
    final result = await delete(
      Uri.parse(path),
      headers: ApiHeader.tokenHeader(),
      // encoding: Encoding.getByName("utf-8"),
    );
    if (kDebugMode) {
      // SACHiN
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("TYPE => DELETE");
      log("STATUS => ${result.statusCode}");
      // log("REQUEST => ${jsonEncode(parameters)} ");
      log("HEADERS => ${ApiHeader.tokenHeader()} ");
      log("RESPONSE => ${result.body}\n$path");
    }
    await _isLogout(result.statusCode);

    return result;
  }

  static Future<Response> getAPi({required String path, peraToken}) async {
    var url = Uri.parse(path);
    final result = await get(
      url,
      headers: ApiHeader.tokenHeader(),
    );

    if (kDebugMode) {
      // SACHiN
      log("TIME =>${DateTime.now()}");
      log("PATH => $path");
      log("REQUEST TYPE => GET ");
      log("STATUS => ${result.statusCode}");
      log("HEADERS => ${ApiHeader.tokenHeader()} ");
      log("RESPONSE => ${result.body}\n$path");
    }

    await _isLogout(result.statusCode);

    return result;
  }

  static _isLogout(status) async {
    if (status == statusCode401) {
      await _logout();
    }
  }

  // Multipart request without token
  static Future<Response> multipartAPI({
    required String path,
    required Map<String, dynamic> body,
    required bool isUpdate,
  }) async {
    var url = Uri.parse(path);
    // print(url);

    var request = MultipartRequest(isUpdate ? 'PUT' : 'POST', url);
    // print(body.);

    body.updateAll((key, value) async {
      print(" $key || $value ");
      if (value is File) {
        log("File");
        request.files.add(await MultipartFile.fromPath(key, value.path));
      } else if (value != null) {
        if (!value.toString().contains("https")) {
          request.fields[key] = value.toString().trim();
        } else {
          request.fields["portal"] = true.toString();
        }
      }
    });
    final id_token = await Session.idToken();
    request.headers.addAll({
      // "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      "Authorization": "Bearer $id_token",
    });
    StreamedResponse response = await request.send();

    return Response(await response.stream.bytesToString(), response.statusCode);
  }


  static _logout() async {
    Session.sharedPreferences!.clear();
    navigatorKey!.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignupScreen()), (
        route) => false);
  }
}