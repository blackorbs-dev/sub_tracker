import 'package:local_auth/local_auth.dart';
import 'package:sub_tracker/core/error/extensions.dart';

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e, stacktrace) {
      e.printDebug(tag: 'BioMetric Error');
      stacktrace.printDebug(tag: 'Stacktrace');
      return false;
    }
  }
}
