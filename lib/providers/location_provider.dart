import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends BaseProvider {
  LatLng? _busLocation;

  LatLng? get busLocation => _busLocation;

  set busLocation(LatLng? value) {
    _busLocation = value;
  }

  LatLng? _startingPoint;

  LatLng? get startingPoint => _startingPoint;

  set startingPoint(LatLng? value) {
    _startingPoint = value;
  }

  LatLng? _endingPoint;

  LatLng? get endingPoint => _endingPoint;

  set endingPoint(LatLng? value) {
    _endingPoint = value;
  }

  void trackBus(
      LatLng busLocation, LatLng? startingPoint, LatLng? endingPoint) async {
    this.busLocation = busLocation;
    this.startingPoint = startingPoint;
    this.endingPoint = endingPoint;
    notifyListeners();
  }
}
