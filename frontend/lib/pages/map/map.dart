import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/constants/color.dart';
import 'package:frontend/constants/text.dart';
import 'package:latlong2/latlong.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  TextEditingController _searchController = TextEditingController();

  var ipAdress;
  var locationResponse;
  bool _option1Checked = false;

  //Method for Location in Desktop devices
  Future<String> getIsp() async {
    var response = await http.get(Uri.parse("https://api.ipify.org/"));
    return response.body;
  }

  Future getLocationDeskTop() async {
    var ipAdress = await getIsp();
    var response =
        await http.get(Uri.parse("http://ip-api.com/json/$ipAdress"));
    var jsonparse = json.decode(response.body);
    locationResponse = jsonparse;
    print(jsonparse);
  }

  void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text(
              'The app cannot access your location. Please open the app settings and enable the location permission.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                AppSettings.openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Method for Location with phone devices
  Future<LatLng> getCurrentLocation(Function showDialogCallback) async {
    try {
      // Check if location permission is granted
      ph.PermissionStatus permissionStatus =
          await ph.Permission.location.status;

      if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
        // If permission is denied, show the permission denied dialog
        showDialogCallback(context);

        return LatLng(43.61042827449398,
            3.8631759464780946); // Return a default value or handle the error
      } else if (permissionStatus.isRestricted || permissionStatus.isLimited) {
        // If permission is restricted or limited, request permission
        permissionStatus = await ph.Permission.location.request();
        if (!permissionStatus.isGranted) {
          return LatLng(43.61042827449398,
              3.8631759464780946); // Return a default value or handle the error
        }
      }

      // If permission is granted, get the current location
      Location location = Location();
      location.enableBackgroundMode(enable: true);
      LocationData locationData = await location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print(e);
      return LatLng(43.61042827449398,
          3.8631759464780946); // Return a default value or handle the error
    }
  }

  LatLng userLocation =
      LatLng(43.61042827449398, 3.8631759464780946); // Default location

  Future<void> updateLocation() async {
    //if phone devices :
    if (Platform.isAndroid || Platform.isIOS) {
      LatLng location = await getCurrentLocation(showPermissionDeniedDialog);
      if (mounted) {
        setState(() {
          userLocation = location;
        });
      }
    }
    //if desktop or web devices
    else {
      await getIsp();
      await getLocationDeskTop();
      if (mounted) {
        setState(() {
          userLocation =
              LatLng(locationResponse['lat'], locationResponse['lon']);
        });
      }
    }
    if (mounted) {
      mapController.move(userLocation, mapController.zoom);
    }
  }

  MapController mapController = MapController();

Widget buildFilterBottomSheet(BuildContext context) {
  return Align( 
    alignment: Alignment.topCenter,
    child: Container(
    height: MediaQuery.of(context).size.height * 0.25,
    width: MediaQuery.of(context).size.width * 0.8,
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: ConstantsColors.blackText,
      borderRadius: BorderRadius.all(Radius.circular(25)
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        H2Text( text: 'Filtrer les évènements : ')
      ],
    ),
    ),
  );
}
  @override
  void initState() {
    super.initState();
    updateLocation();
    _option1Checked = false;

  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options:
            MapOptions(center: userLocation, minZoom: 5, maxZoom: 25, zoom: 18),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/dark-v10',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: userLocation,
                builder: (context) {
                  return const Icon(
                    Icons.radio_button_checked,
                    color: ConstantsColors.primaryColor,
                    size: 44,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
            Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            
            Padding(
              padding: const EdgeInsets.only(left: 20),
            child: Container(
            height: 60,
            width: 220,
            decoration: BoxDecoration(
                color: ConstantsColors.blackText,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(47, 255, 255, 255),
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal)
                      ]),
            child: Center(
                child: TextField(
                    style:  const TextStyle(
                          color: ConstantsColors.primaryText,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          decorationThickness: 0),
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded),
                      prefixIconColor: ConstantsColors.primaryText,
                      suffixIconColor: ConstantsColors.primaryText,
                      iconColor: ConstantsColors.primaryText,
                      hintText: 'Search...',
                      prefixStyle: const TextStyle(
                          color: ConstantsColors.primaryText,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                      helperStyle: const TextStyle(
                          color: ConstantsColors.primaryText,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                      labelStyle: const TextStyle(
                          color: ConstantsColors.primaryText,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                      hintStyle: const TextStyle(
                          color: ConstantsColors.primaryText,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    )
                )
              )
            ),
            ),
           Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: ConstantsColors.blackText,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(47, 255, 255, 255),
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: IconButton(
                      onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return buildFilterBottomSheet(context);
                            });
                      },
                      icon: const Icon(
                        Icons.tune_rounded,
                        color: ConstantsColors.primaryText,
                        size: 30,
                        shadows: [],
                ))))])),
          SizedBox(height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2.3 ,),
          Padding(padding: const EdgeInsets.only(right: 20) ,
          child: Align(
            alignment: Alignment.bottomRight,child: 
            Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: ConstantsColors.blackText,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(47, 255, 255, 255),
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: IconButton(
                      onPressed: () {
                        updateLocation();
                      },
                      icon: const Icon(
                        Icons.gps_fixed,
                        color: ConstantsColors.primaryText,
                        size: 30,
                        shadows: [],
                )))))])
    ]);
  }
}


