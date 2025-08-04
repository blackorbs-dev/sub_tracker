import 'dart:async';

import 'package:flutter/services.dart';

import '../error/extensions.dart';
import '../error/error.dart';
import 'response.dart';

Future<Response<T, DataError>> safeCall<T>(Future<T> Function() request) async {
  try {
    final response = await request();
    return SuccessResponse(response);
  }
  on FormatException catch (e, stacktrace) {
    e.printDebug(tag: 'Serialization Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.serialization());
  }
  on TimeoutException catch (e, stacktrace) {
    e.printDebug(tag: 'Timeout Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.timeout());
  }
  on CustomException catch (e, stacktrace) {
    e.printDebug(tag: 'Custom Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.message(e.message));
  }
  on PlatformException catch (e, stacktrace) {
    e.printDebug(tag: 'Platform Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.platform());
  }
  catch (e, stacktrace) {
    e.printDebug(tag: 'Unknown Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.unknown());
  }
}
