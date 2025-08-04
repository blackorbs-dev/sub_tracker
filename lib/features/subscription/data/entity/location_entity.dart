import 'package:objectbox/objectbox.dart';

@Entity()
class LocationEntity{
  @Id()
  int id;
  final double latitude;
  final double longitude;
  final String address;

  LocationEntity({
    this.id = 0,
    required this.latitude,
    required this.longitude,
    required this.address
  });

}