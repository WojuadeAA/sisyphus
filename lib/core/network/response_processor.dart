import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// This is  a DRY function
/// to process network responses
/// throws exception if the response is an error.
Future<T> processResponse<T>({
  ///this is the response object
  required Response<dynamic> response,

  ///this is the function used to do the serialization.
  required T Function(dynamic) serializer,

  ///This is the code to check for in the response.
  int successCode = 200,

  //The map is the error serialized.
  Exception Function(dynamic)? serializeError,
}) async {
  final data = response.data!;

  if ((response.statusCode ?? 400) < (successCode + 90)) {
    try {
      return serializer(data);
    } on Exception catch (_) {
      rethrow;
    }
  } else {
    if (serializeError != null) {
      throw serializeError(data);
    } else {
      debugPrint(response.statusCode.toString());
      final errors = data;
      if (kDebugMode) log(errors.toString());
      var message = '';
      try {
        if (errors['message'] != null) {
          message = errors['message'].toString();
        }
        //handle password error message appearing in list issue

        throw Exception(
          message.replaceAll(RegExp(r'(?:errors)|[{}\[\]\:]'), ''),
        );
      } on Exception catch (_) {
        rethrow;
      }
    }
  }
}
