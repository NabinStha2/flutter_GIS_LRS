// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gis_flutter_frontend/widgets/custom_circular_progress_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'package:gis_flutter_frontend/core/development/console.dart';
import 'package:gis_flutter_frontend/main.dart';
import 'package:gis_flutter_frontend/providers/map_provider.dart';
import 'package:gis_flutter_frontend/widgets/custom_text.dart';

import '../model/land/land_request_model.dart';
import '../providers/land_provider.dart';
import '../widgets/drawer_widget.dart';
import 'dashboard_page.dart';

ValueNotifier<List<Map<String, dynamic>>> latlngList =
    ValueNotifier<List<Map<String, dynamic>>>([
  {
    "polygonData": [
      LatLng(28.2550, 83.9761),
      LatLng(28.2549, 83.9762),
      LatLng(28.2553, 83.9766),
      LatLng(28.2554, 83.9764),
    ],
    "parcelId": "10",
  }
]);

TextEditingController searchController = TextEditingController();
MapController mapController = MapController();

class MapPage extends StatefulWidget {
  final bool? isFromLand;
  final LatLng? latlngData;
  const MapPage({
    Key? key,
    this.isFromLand,
    this.latlngData,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    consolelog("iam from init map");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LandProvider>(context, listen: false).getOwnedLands(
          context: context,
          landRequestModel: LandRequestModel(page: 1, limit: 20),
          isFromMap: true,
          latlngData: widget.isFromLand ?? false ? widget.latlngData : null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.ourText(
          "Map",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      drawerEnableOpenDragGesture: false,
      drawer: widget.isFromLand ?? false
          ? null
          : DrawerWidget(
              scKey: scKey,
            ),
      body: Consumer2<MapProvider, LandProvider>(
        builder: (context, _, __, child) => __.isLoading
            ? const CustomCircularProgressIndicatorWidget(
                title: "Loading Map data...",
              )
            : Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        onPointerHover: (PointerHoverEvent pointerHoverEvent,
                            LatLng location) {
                          // debugPrint("${pointerHoverEvent.toString()} :: $location");
                        },
                        onTap: (tapPosition, LatLng location) {
                          debugPrint(
                              "${tapPosition.global.distance.toString()} :: $location");
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              SnackBar(
                                content: CustomText.ourText(
                                  location.toString(),
                                  color: Colors.white,
                                ),
                              ),
                            );
                        },
                        center: LatLng(currentPosition?.latitude ?? 0.0,
                            currentPosition?.longitude ?? 0.0),
                        zoom: 5,
                        maxZoom: 22,
                        enableScrollWheel: true,
                        scrollWheelVelocity: 0.008,
                        keepAlive: true,
                        minZoom: 0.0,
                        onMapReady: () {
                          widget.isFromLand == true && widget.latlngData != null
                              ? mapController.move(widget.latlngData!, 18)
                              : null;
                        }),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: 'OpenStreetMap contributors',
                        onSourceTapped: () {},
                      ),
                    ],
                    children: [
                      IndexedStack(
                        index: _.tileLayerIndex,
                        children: [
                          TileLayer(
                            maxNativeZoom: 18,
                            maxZoom: 22,
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                            retinaMode: true &&
                                MediaQuery.of(context).devicePixelRatio > 1.0,
                          ),
                          TileLayer(
                            maxNativeZoom: 18,
                            maxZoom: 22,
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          TileLayer(
                            maxNativeZoom: 18,
                            maxZoom: 22,
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          TileLayer(
                            maxNativeZoom: 18,
                            maxZoom: 22,
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v12/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibmFiaW5zdGhhMTIiLCJhIjoiY2xlazVqZGNjMGkyNTQzazU3dHpqd2thdiJ9.-DPZDLlSeIZg5uAl9hBOrA",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                            retinaMode: true &&
                                MediaQuery.of(context).devicePixelRatio > 1.0,
                            tileBuilder: (context, _, tile) =>
                                CustomText.ourText(
                              '${tile.coords.x.floor()} : ${tile.coords.y.floor()} : ${tile.coords.z.floor()}',
                            ),
                          ),
                          TileLayer(
                            urlTemplate:
                                'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                              point: LatLng(currentPosition?.latitude ?? 0.0,
                                  currentPosition?.longitude ?? 0.0),
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
                            points: latlngList.value[index]["polygonData"],
                            isFilled: false,
                            borderColor: Colors.red,
                            borderStrokeWidth: 1,
                            label: latlngList.value[index]["parcelId"],
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
                    bottom: 70,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        _.tileLayerIndex >= 0 && _.tileLayerIndex < 4
                            ? _.changeTileLayerIndex(_.tileLayerIndex + 1)
                            : _.tileLayerIndex == 4
                                ? _.changeTileLayerIndex(0)
                                : null;
                      },
                      icon: const Icon(
                        Icons.change_circle,
                        size: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        mapController.move(
                            LatLng(currentPosition?.latitude ?? 0.0,
                                currentPosition?.longitude ?? 0.0),
                            18);
                      },
                      icon: const Icon(
                        Icons.location_searching,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
