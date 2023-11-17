import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? _currPositionMarker;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(-6.892520, 107.608534);
  StreamSubscription<loc.LocationData>? locationSubscription;
  bool isFollowCamera = true;
  List<LatLng> listPoint = [
    const LatLng(-6.898252, 107.603890),
    const LatLng(-6.889169, 107.596794),
    const LatLng(-6.889572, 107.604134),
    const LatLng(-6.893743, 107.604099),
    const LatLng(-6.889485, 107.604101),
  ];
  List<Marker> listPointMarker = [];
  List<PolylineWayPoint> listPolyLineWayPoints = [];
  String distance = '';
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  double distanceInKilometers = 0;
  double durationInMinutes = 0;

  @override
  void initState() {
    if (mounted) {
      super.initState();
      addMarker();
      getNavigation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: UniqueKey(),
            backgroundColor: backgroundColor,
            child: Icon(
              Icons.gps_fixed,
              color: greyColor,
            ),
            onPressed: () async {
              if (!isFollowCamera) {
                final GoogleMapController? controller =
                    await _controller.future;
                controller?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target:
                          LatLng(curLocation.latitude, curLocation.longitude),
                      zoom: 16,
                    ),
                  ),
                );
                setState(() {
                  isFollowCamera = true;
                });
              }
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: secondaryColor,
            child: const Icon(
              Icons.navigation_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              String wayPoints = '';
              for (var element in listPoint) {
                if (element == listPoint.last) {
                  wayPoints += ('${element.latitude},${element.longitude}');
                } else if (element != listPoint.first) {
                  wayPoints += ('${element.latitude},${element.longitude}|');
                }
              }
              String googleMapsUrl =
                  'https://www.google.com/maps/dir/?api=1&origin=${listPoint.first.latitude},${listPoint.first.longitude}&destination=${listPoint.first.latitude},${listPoint.first.longitude}&waypoints=$wayPoints&travelmode=driving';
              await launchUrl(Uri.parse(googleMapsUrl));
            },
          ),
          const SizedBox(height: 24)
        ],
      ),
      body: _currPositionMarker == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    polylines: Set<Polyline>.of(polylines.values),
                    initialCameraPosition: CameraPosition(
                      target: curLocation,
                      zoom: 16,
                    ),
                    // myLocationEnabled: true,
                    // myLocationButtonEnabled: true,
                    markers: {
                      ...listPointMarker.toSet(),
                      ...{_currPositionMarker!}
                    },
                    onCameraMoveStarted: () {
                      setState(() {
                        isFollowCamera = false;
                      });
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin:
                          const EdgeInsets.only(right: 24, top: 16, left: 72),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: greyColor.withOpacity(0.1),
                            offset: const Offset(
                              0,
                              0,
                            ),
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Next Destinations',
                            style: secondaryText.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                          Text(
                            'Distance: ${distanceInKilometers.toStringAsFixed(2)} km',
                            style: primaryText.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            'Duration: ${durationInMinutes.toStringAsFixed(2)} mins',
                            style: primaryText.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  getNavigation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription = location.onLocationChanged
          .listen((LocationData updatedLocation) async {
        if (isFollowCamera) {
          controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                    updatedLocation.latitude!, updatedLocation.longitude!),
                zoom: 16,
              ),
            ),
          );
        }
        setState(() {
          curLocation =
              LatLng(updatedLocation.latitude!, updatedLocation.longitude!);
          _currPositionMarker = Marker(
            markerId: const MarkerId('currentMarker'),
            icon: currentLocationIcon,
            position: LatLng(curLocation.latitude, curLocation.longitude),
            infoWindow: const InfoWindow(
              title: "MediGuard",
            ),
          );
        });
        controller?.showMarkerInfoWindow(const MarkerId('currentMarker'));
      });
      getDirections();
    }
  }

  Future<void> getDirections() async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDuTisit6x-u0A11_YhB6v05CFFQEmPjsk',
      PointLatLng(curLocation.latitude, curLocation.longitude),
      PointLatLng(listPoint.first.latitude, listPoint.first.longitude),
      wayPoints: listPolyLineWayPoints,
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    await addPolyLine(polylineCoordinates);

    // Menghitung distance dan duration
    setState(() {
      distanceInKilometers = result.distanceValue! / 1000;
      durationInMinutes = result.durationValue! / 60;
    });
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: secondaryColor,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  addMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/myloc.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
    setState(() {
      _currPositionMarker = Marker(
        markerId: const MarkerId('currentMarker'),
        position: listPoint.first,
        icon: currentLocationIcon,
      );
      for (var latLng in listPoint) {
        if (latLng == listPoint.first) {
          listPointMarker.add(
            Marker(
              markerId: MarkerId(
                latLng.latitude.toString() + latLng.longitude.toString(),
              ),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan),
              infoWindow: const InfoWindow(title: "Gudang"),
            ),
          );
        } else {
          listPointMarker.add(
            Marker(
              markerId: MarkerId(
                latLng.latitude.toString() + latLng.longitude.toString(),
              ),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          );
          listPolyLineWayPoints.add(PolylineWayPoint(
              location: '${latLng.latitude},${latLng.longitude}'));
        }
      }
    });
  }
}
