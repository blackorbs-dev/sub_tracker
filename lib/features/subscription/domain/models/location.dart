import 'package:equatable/equatable.dart';

class Location extends Equatable{
  final double latitude;
  final double longitude;
  final String address;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.address
  });

  @override
  List<Object?> get props => [latitude, longitude, address];

  @override
  bool get stringify => true;
}