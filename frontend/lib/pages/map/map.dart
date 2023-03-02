import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

final myPosition = LatLng(43.632848, 3.843535);

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        FlutterMap(
          options:
              MapOptions(center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken': MAPBOX_ACCESS_TOKEN,
                'id': 'mapbox/streets-v12'
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: myPosition,
                  builder: (context) {
                    return const Icon(
                      Icons.person_pin,
                      color: Constants.lightBackground,
                      size: 40,
                    );
                  },
                )
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimSearchBar(
            width: 450,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                textController.clear();
              });
            },
            onSubmitted: (String value) {
              setState(() {
                textController.clear();
              });
            },
            autoFocus: true,
            closeSearchOnSuffixTap: true,
            animationDurationInMilli: 400,
            rtl: true,
            helpText: "Search Text...",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ]),
    ));
  }
}
