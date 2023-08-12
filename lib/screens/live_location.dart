import 'dart:async';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
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
  LatLng? startingLocation;
  LatLng? endingLocation;
  // static const LatLng sourceLocation = LatLng(37.4116, -122.0713);
  // static const LatLng destination = LatLng(37.4221, -122.0841);
  bool markingStartLocation = false;
  bool markingEndLocation = false;
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
                  child: GoogleMap(
                    onTap: (LatLng tappedLatLng) {
                      setState(() {
                        if (markingStartLocation) {
                          startingLocation = tappedLatLng;
                          markingStartLocation = false;
                        } else if (markingEndLocation) {
                          endingLocation = tappedLatLng;
                          markingEndLocation = false;
                        }
                      });
                    },
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
                      if (startingLocation != null)
                        Marker(
                          markerId: MarkerId("startingLocation"),
                          position: startingLocation!,
                          icon: sourceIcon,
                        ),
                      if (endingLocation != null)
                        Marker(
                          markerId: MarkerId("endingLocation"),
                          position: endingLocation!,
                          icon: destinationIcon,
                        ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppColors.gradientColorsButtom,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,

                          elevation: 0, // No shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            markingStartLocation = true;
                            markingEndLocation = false;
                          });
                        },
                        child: Text(
                          LocaleKeys.startingPoint.tr(),
                          style: AppTextStyles.poppinsTitle
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppColors.gradientColorsButtom,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,

                          elevation: 0, // No shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            markingStartLocation = false;
                            markingEndLocation = true;
                          });
                        },
                        child: Text(
                          LocaleKeys.endPoint.tr(),
                          style: AppTextStyles.poppinsTitle
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
