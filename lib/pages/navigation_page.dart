import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:mediguard/shared/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

class NavigationPage extends StatefulWidget {
  const NavigationPage(this.lat, this.lng, {super.key});
  final double lat;
  final double lng;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(-6.892520, 107.608534);
  StreamSubscription<loc.LocationData>? locationSubscription;
  bool isFollowCamera = true;

  @override
  void initState() {
    super.initState();
    getNavigation();
    addMarker();
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
          const SizedBox(height: 24),
          FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: secondaryColor,
            child: const Icon(
              Icons.navigation_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              await launchUrl(Uri.parse(
                  'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyDuTisit6x-u0A11_YhB6v05CFFQEmPjsk'));
            },
          ),
        ],
      ),
      body: sourcePosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: curLocation,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {sourcePosition!, destinationPosition!},
                  onCameraMoveStarted: () {
                    setState(() {
                      isFollowCamera = false;
                    });
                  },
                  onTap: (latLng) {
                    print(latLng);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
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
      locationSubscription =
          location.onLocationChanged.listen((LocationData updatedLocation) {
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
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(updatedLocation.latitude!, updatedLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(updatedLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(updatedLocation.latitude!, updatedLocation.longitude!),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDuTisit6x-u0A11_YhB6v05CFFQEmPjsk',
      PointLatLng(curLocation.latitude, curLocation.longitude),
      PointLatLng(dst.latitude, dst.longitude),
      wayPoints: <PolylineWayPoint>[
        PolylineWayPoint(location: "-6.893841, 107.605092", stopOver: true),
        PolylineWayPoint(location: "-6.893841, 107.605092", stopOver: true),
        PolylineWayPoint(location: "-6.893841, 107.605092", stopOver: true),
      ],
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    });
  }
}
