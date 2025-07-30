import 'package:flutter/foundation.dart';

import 'error.dart';

extension ExceptionLogger on Object {
  void printDebug({String tag = ''}) {
    if(kDebugMode) {
      debugPrint('$tag: $this');
    }
  }
}

extension Message on DataError{
  String message() => switch(this){
    InvalidCredentialsError() => 'Invalid credentials',
    ErrorMessage(:final message) => message,
    _ => 'Oops, something went wrong, please try again.'
  };
}