class CustomException implements Exception {
  final String message;
  const CustomException(this.message);
}

abstract class Error{}

sealed class DataError implements Error {
  const DataError();

  const factory DataError.unknown() = UnknownError;
  const factory DataError.serialization() = SerializationError;
  const factory DataError.platform() = Platform;
  const factory DataError.timeout() = TimeoutError;
  const factory DataError.invalidCredentials() = InvalidCredentialsError;
  const factory DataError.message(String message) = ErrorMessage;
}

class UnknownError extends DataError {
  const UnknownError();
}

class SerializationError extends DataError {
  const SerializationError();
}

class Platform extends DataError {
  const Platform();
}

class TimeoutError extends DataError {
  const TimeoutError();
}

class InvalidCredentialsError extends DataError {
  const InvalidCredentialsError();
}

class ErrorMessage extends DataError {
  final String message;
  const ErrorMessage(this.message);
}
