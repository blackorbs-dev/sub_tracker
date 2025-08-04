import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../features/subscription/data/entity/location_entity.dart';
import '../error/extensions.dart';

Future<LocationEntity?> getCurrentLocation() async{
  final geolocatorPlatform = GeolocatorPlatform.instance;
  final permission = await geolocatorPlatform.checkPermission();
  if(permission == LocationPermission.denied){
    await geolocatorPlatform.requestPermission();
  }
  final location = await geolocatorPlatform.getCurrentPosition();
  final address = await getAddressFromLatLng(location.latitude, location.longitude);
  return address == null ? null : LocationEntity(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address
  );
}

Future<String?> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return '${place.locality}, ${place.administrativeArea}';
    }
  } catch (e) {
    ('Error in reverse geocoding: $e').printDebug();
  }
  return null;
}