import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/location_provider.dart';
import 'package:educloud_mobile/services/pusherLocation.dart';

import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class TrackingBus extends StatefulWidget {
  const TrackingBus({Key? key}) : super(key: key);
  @override
  State<TrackingBus> createState() => TrackingBusState();
}

class TrackingBusState extends State<TrackingBus> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? startingLocation;
  LatLng? endingLocation;
  LocationData? currentLocation;
  LatLng? LocationTrackingdata;
  // dynamic data = {};
  String data = "";

  // static const LatLng sourceLocation = LatLng(37.4116, -122.0713);
  // static const LatLng destination = LatLng(37.4221, -122.0841);
  bool markingStartLocation = false;
  bool markingEndLocation = false;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor busIcon = BitmapDescriptor.defaultMarker;
  StreamSubscription<LocationData>? locationSubscription;
  bool receivingLocationUpdates = false;
  PusherLocationService _pusherLocationService = PusherLocationService();
  LatLng? busLocation, startingPoint, endingPoint;
  Timer? _timer;
  Future<void> checkLocationServices() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      bool shouldRequest = await location.requestService();
      if (!shouldRequest) {
        // The user declined to enable location services
        return;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    print("init pusher -------------");
    _pusherLocationService.initPusher();
    getCurrentLocation();
    setCustomMarkerIcon();
    checkLocationServices();

    super.initState();
    // getPolyPoints();
  }

  @override
  void dispose() {
    locationSubscription?.cancel(); // Cancel the location subscription
    _pusherLocationService.dispose();
    _controller.future
        .then((controller) => controller.dispose()); // Dispose of controller
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void setCustomMarkerIcon() async {
    final Uint8List markerSourceIcon =
        await getBytesFromAsset('assets/location/university.png', 100);
    final Uint8List markerDestinationIcon =
        await getBytesFromAsset('assets/location/bus-station.png', 100);
    final Uint8List markerCurrentLocationIcon =
        await getBytesFromAsset('assets/location/location.png', 100);
    final Uint8List markerBusIcon =
        await getBytesFromAsset('assets/location/bus.png', 100);
    sourceIcon = BitmapDescriptor.fromBytes(markerSourceIcon);
    destinationIcon = BitmapDescriptor.fromBytes(markerDestinationIcon);
    currentLocationIcon = BitmapDescriptor.fromBytes(markerCurrentLocationIcon);
    busIcon = BitmapDescriptor.fromBytes(markerBusIcon);
  }

  void getCurrentLocation() async {
    Location location = Location();
    locationSubscription = location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        final googleMapController = _controller.future;
        googleMapController.then(
          (controller) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 13.5,
                  target: LatLng(
                    newLoc.latitude!,
                    newLoc.longitude!,
                  ),
                ),
              ),
            );
          },
        );
        if (mounted) {
          // Check if the widget is still mounted before calling setState
          setState(() {});
        }
      },
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.gradientColorsButtom,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
              onPressed: () => Navigator.of(context).pop(),
              color: AppColors.secondaryColor,
            ),
            title: Text(
              LocaleKeys.maps.tr(),
              style: AppTextStyles.textTitleStyle
                  .copyWith(color: AppColors.secondaryColor),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Consumer<LocationProvider>(
                    builder: (context, value, child) => GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!),
                        zoom: 13.5,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: currentLocationIcon,
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        if (value.busLocation != null)
                          Marker(
                            markerId: const MarkerId("BusLocation"),
                            icon: busIcon,
                            position: value.busLocation!,
                          ),
                        if (value.startingPoint != null)
                          Marker(
                            markerId: MarkerId("startingLocation"),
                            position: value.startingPoint!,
                            icon: sourceIcon,
                          ),
                        if (value.endingPoint != null)
                          Marker(
                            markerId: MarkerId("endingLocation"),
                            position: value.endingPoint!,
                            icon: destinationIcon,
                          ),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
