import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/models/location.dart';
import '../../domain/models/subscription.dart';
import '../../domain/repository/subscription_repository.dart';
import '../extensions.dart';

part 'sub_history_state.dart';

class SubHistoryCubit extends Cubit<SubHistoryState> {
  StreamSubscription? _subHistoryStream;
  final Map<Location, Color> _locationColorMap = {};
  final markers = <Marker>{};
  int _nextIndex = 0;

  final SubscriptionRepository _repository;

  SubHistoryCubit(this._repository) : super(const SubHistoryState.initial()){
    _init();
  }

  void _init() async{
    _subHistoryStream = (await _repository.getAllSubscription())
        .listen((subscriptions) {
          emit(getSubData(subscriptions));
        }
    );
  }

  Loaded getSubData(List<Subscription> subscriptions){
    for (final sub in subscriptions) {
      final loc = sub.location;
      if (loc != null && !_locationColorMap.containsKey(loc)) {
        final color = colorFromIndex(_nextIndex++);
        _locationColorMap[loc] = color;

        markers.add(
          Marker(
            markerId: MarkerId(loc.toString()),
            position: LatLng(loc.latitude, loc.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              _colorToHue(color),
            ),
          ),
        );
      }
    }
    return Loaded(
      subscriptions,
      Map<Location, Color>.from(_locationColorMap),
      markers
    );
  }

  /// Convert a [Color] to a hue value for Google Maps markers.
  double _colorToHue(Color color) {
    final hsv = HSVColor.fromColor(color);
    return hsv.hue;
  }

  @override
  Future<void> close() {
    _subHistoryStream?.cancel();
    return super.close();
  }
}
