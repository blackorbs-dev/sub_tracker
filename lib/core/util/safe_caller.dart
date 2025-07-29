import 'dart:async';

import '../error/extensions.dart';
import '../error/error.dart';
import 'response.dart';

Future<Response<T, DataError>> safeCall<T>(dynamic Function() request) async {
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
  catch (e, stacktrace) {
    e.printDebug(tag: 'Unknown Error');
    stacktrace.printDebug(tag: 'Stacktrace');
    return ErrorResponse(DataError.unknown());
  }
}
