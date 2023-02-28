import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gis_flutter_frontend/main.dart';
import 'package:gis_flutter_frontend/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

ValueNotifier<List<List<LatLng>>> latlngList = ValueNotifier<List<List<LatLng>>>([
  [
    LatLng(28.2550, 83.9761),
    LatLng(28.2549, 83.9762),
    LatLng(28.2553, 83.9766),
    LatLng(28.2554, 83.9764),
  ],
]);

TextEditingController searchController = TextEditingController();

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();

  @override
  void initState() {
    debugPrint("from init of map");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("kisweb :: $kIsWeb");
    return kIsWeb
        ? Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  onPointerHover: (PointerHoverEvent pointerHoverEvent, LatLng location) {
                    // debugPrint("${pointerHoverEvent.toString()} :: $location");
                  },
                  onTap: (tapPosition, LatLng location) {
                    debugPrint("${tapPosition.global.distance.toString()} :: $location");
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        SnackBar(
                          content: CustomText.ourText(
                            location.toString(),
                          ),
                        ),
                      );
                  },
                  center: LatLng(currentPosition?.latitude ?? 0.0, currentPosition?.longitude ?? 0.0),
                  zoom: 5,
                  maxZoom: 22,
                  enableScrollWheel: true,
                  // keepAlive: true,
                  minZoom: 0.0,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: () {},
                  ),
                ],
                children: [
                  TileLayer(
                    maxNativeZoom: 18,
                    maxZoom: 22,
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // TileLayer(
                  //   maxNativeZoom: 18,
                  //   maxZoom: 22,
                  //   urlTemplate:
                  //       "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                  //   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  // ),
                  // TileLayer(
                  //   maxNativeZoom: 18,
                  //   maxZoom: 22,
                  //   urlTemplate:
                  //       "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                  //   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  // ),
                  // TileLayer(
                  //   maxNativeZoom: 18,
                  //   maxZoom: 22,
                  //   urlTemplate:
                  //       "https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v12/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                  //   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  //   retinaMode: true && MediaQuery.of(context).devicePixelRatio > 1.0,
                  //   tileBuilder: (context, _, tile) => CustomText(
                  //     text: '${tile.coords.x.floor()} : ${tile.coords.y.floor()} : ${tile.coords.z.floor()}',
                  //   ),
                  // ),
                  // TileLayer(
                  //   urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                  //   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  // ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          point: LatLng(currentPosition?.latitude ?? 0.0, currentPosition?.longitude ?? 0.0),
                          builder: (BuildContext context) {
                            return Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent,
                              ),
                            );
                          })
                    ],
                  ),
                  PolygonLayer(
                    polygonCulling: true,
                    polygons: List.generate(
                      latlngList.value.length,
                      (index) => Polygon(
                        points: latlngList.value[index],
                        isFilled: false,
                        borderColor: Colors.red,
                        borderStrokeWidth: 1,
                        label: "hey",
                        labelStyle: TextStyle(
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        labelPlacement: PolygonLabelPlacement.centroid,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    mapController.move(LatLng(currentPosition?.latitude ?? 0.0, currentPosition?.longitude ?? 0.0), 13);
                  },
                  icon: const Icon(Icons.location_searching),
                ),
              ),
            ],
          )
        : Container(
            child: CustomText.ourText(
              "Not Web",
            ),
          );
  }
}
