import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.4116, -122.0713);
  static const LatLng destination = LatLng(37.4221, -122.0841);
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  StreamSubscription<LocationData>? locationSubscription;
  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
    // getPolyPoints();
  }

  @override
  void dispose() {
    locationSubscription?.cancel(); // Cancel the location subscription
    _controller.future
        .then((controller) => controller.dispose()); // Dispose of controller
    super.dispose();
  }

  void setCustomMarkerIcon() async {
    final Uint8List markerSourceIcon =
        await getBytesFromAsset('assets/location/university.png', 100);
    final Uint8List markerDestinationIcon =
        await getBytesFromAsset('assets/location/bus-station.png', 100);
    final Uint8List markerCurrentLocationIcon =
        await getBytesFromAsset('assets/location/bus.png', 100);
    sourceIcon = BitmapDescriptor.fromBytes(markerSourceIcon);
    destinationIcon = BitmapDescriptor.fromBytes(markerDestinationIcon);
    currentLocationIcon = BitmapDescriptor.fromBytes(markerCurrentLocationIcon);
  }

  LocationData? currentLocation;

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
      appBar: AppBar(
        title: Text("maps"),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                  icon: sourceIcon,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                  icon: destinationIcon,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
