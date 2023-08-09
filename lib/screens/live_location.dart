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
  // bool _loading = false;
  // int _polylineCount = 1;
  // Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  // GoogleMapPolyline _googleMapPolyline =
  //     new GoogleMapPolyline(apiKey: google_api_key);

  // //Polyline patterns
  // List<List<PatternItem>> patterns = <List<PatternItem>>[
  //   <PatternItem>[], //line
  //   <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
  //   <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
  //   <PatternItem>[
  //     //dash-dot
  //     PatternItem.dash(30.0),
  //     PatternItem.gap(20.0),
  //     PatternItem.dot,
  //     PatternItem.gap(20.0)
  //   ],
  // ];
  // //Get polyline with Location (latitude and longitude)
  // _getPolylinesWithLocation() async {
  //   _setLoadingMenu(true);
  //   List<LatLng>? _coordinates =
  //       await _googleMapPolyline.getCoordinatesWithLocation(
  //           origin: sourceLocation,
  //           destination: destination,
  //           mode: RouteMode.driving);

  //   setState(() {
  //     _polylines.clear();
  //   });
  //   _addPolyline(_coordinates);
  //   _setLoadingMenu(false);
  // }

  // //Get polyline with Address

  // _addPolyline(List<LatLng>? _coordinates) {
  //   PolylineId id = PolylineId("poly$_polylineCount");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       patterns: patterns[0],
  //       color: Colors.blueAccent,
  //       points: _coordinates!,
  //       width: 10,
  //       onTap: () {});

  //   setState(() {
  //     _polylines[id] = polyline;
  //     _polylineCount++;
  //   });
  // }

  // _setLoadingMenu(bool _status) {
  //   setState(() {
  //     _loading = _status;
  //   });
  // }

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
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/location/university.png")
    //     .then(
    //   (icon) {
    //     sourceIcon = icon;
    //   },
    // );
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/location/bus-station.png")
    //     .then(
    //   (icon) {
    //     destinationIcon = icon;
    //   },
    // );
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration.empty, "assets/location/bus.png")
    //     .then(
    //   (icon) {
    //     currentLocationIcon = icon;
    //   },
    // );
  }

  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        setState(() {});
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
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
        setState(() {});
      },
    );
  }

  // List<LatLng> polylineCoordinates = [];
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     google_api_key, // Your Google Map Key
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }
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
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    // getPolyPoints();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
              //  polylines: Set<Polyline>.of(_polylines.values),
              // polylines: {
              //   Polyline(
              //     polylineId: const PolylineId("route"),
              //     points: polylineCoordinates,
              //     color: const Color(0xFF7B61FF),
              //     width: 6,
              //   ),
              // },
            ),
    );
  }
}
