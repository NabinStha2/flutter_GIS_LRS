// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/routing/route_navigation.dart';
import 'package:gis_flutter_frontend/screens/map_page.dart';
import 'package:gis_flutter_frontend/utils/custom_toasts.dart';
import 'package:latlong2/latlong.dart';

import '../core/app/colors.dart';
import '../core/app/dimensions.dart';
import '../model/land_response_model.dart';
import 'custom_button.dart';
import 'custom_network_image_widget.dart';

class LandCardWidget extends StatelessWidget {
  LandResult? landResult;
  LandCardWidget({
    Key? key,
    this.landResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.kContainerShadeColor,
        border: Border.all(color: AppColors.kBorderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const CustomNetworkImage(
                imageUrl:
                    "https://img.freepik.com/free-vector/image-upload-concept-illustration_23-2148276163.jpg?size=338&ext=jpg",
              ),
              vSizedBox2,
              CustomButton.elevatedButton(
                "See on map",
                () {
                  landResult?.polygon?.isNotEmpty ?? false
                      ? navigate(
                          context,
                          MapPage(
                            isFromLand: true,
                            latlngData: LatLng(
                                double.parse(
                                    landResult?.polygon?[0].latitude ?? "0"),
                                double.parse(
                                    landResult?.polygon?[0].longitude ?? "0")),
                          ),
                        )
                      : errorToast(msg: "Polygon not available");
                },
              ),
            ],
          ),
          hSizedBox2,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Id: ",
                    style: const TextStyle(
                      color: AppColors.kTextPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: landResult?.id,
                        style: TextStyle(
                          color: AppColors.kHeadingColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox1,
                Text.rich(
                  TextSpan(
                    text: "Parcel Id: ",
                    style: const TextStyle(
                      color: AppColors.kTextPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: landResult?.parcelId,
                        style: TextStyle(
                          color: AppColors.kHeadingColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox1,
                // vSizedBox1,
                // CustomText.ourText(
                //     "Area: ${landResult?.area}"),
                // vSizedBox1,
                // CustomText.ourText(
                //     "Location: ${landResult?.address}, ${landResult?.city}"),
                // vSizedBox1,
                Text.rich(
                  TextSpan(
                    text: "Price: NPR. ",
                    style: const TextStyle(
                      color: AppColors.kTextPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: landResult?.landPrice,
                        style: TextStyle(
                          color: AppColors.kHeadingColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox1,
                Text.rich(
                  TextSpan(
                    text: "status: ",
                    style: const TextStyle(
                      color: AppColors.kTextPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: landResult?.isVerified,
                        style: TextStyle(
                          color: AppColors.kHeadingColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                vSizedBox1,
                CustomButton.elevatedButton(
                  "View Details",
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
