import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/models/location.dart';
import '../entity/location_entity.dart';

extension LocationMapper on LocationEntity{
  Location toModel() => Location(
      latitude: latitude,
      longitude: longitude,
      address: address
  );
}

extension LatLngCenter on Iterable<Location>{
  LatLngBounds? getLatLngBounds() {
    if (isEmpty) return null;

    double minLat = first.latitude;
    double maxLat = first.latitude;
    double minLon = first.longitude;
    double maxLon = first.longitude;

    forEach((loc){
      if (loc.latitude < minLat) minLat = loc.latitude;
      if (loc.latitude > maxLat) maxLat = loc.latitude;
      if (loc.longitude < minLon) minLon = loc.longitude;
      if (loc.longitude > maxLon) maxLon = loc.longitude;
    });

    return LatLngBounds(
      southwest: LatLng(minLat, minLon),
      northeast: LatLng(maxLat, maxLon),
    );
  }
}