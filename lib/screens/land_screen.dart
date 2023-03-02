import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/app/colors.dart';
import 'package:gis_flutter_frontend/core/routing/route_navigation.dart';
import 'package:gis_flutter_frontend/providers/land_provider.dart';
import 'package:gis_flutter_frontend/screens/add_land.dart';
import 'package:gis_flutter_frontend/widgets/custom_button.dart';
import 'package:gis_flutter_frontend/widgets/custom_circular_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../core/app/dimensions.dart';
import '../widgets/custom_network_image_widget.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer_widget.dart';
import 'dashboard_page.dart';

class LandScreen extends StatefulWidget {
  const LandScreen({super.key});

  @override
  State<LandScreen> createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<LandProvider>(context, listen: false)
        .getLands(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.ourText("Land"),
      ),
      drawerEdgeDragWidth: 150,
      drawer: DrawerWidget(
        scKey: scKey,
      ),
      body: Padding(
        padding: screenLeftRightPadding,
        child: Consumer<LandProvider>(
          builder: (context, _, child) => _.isLoading
              ? const CustomCircularProgressIndicatorWidget(
                  title: "Loading lands...",
                )
              : Column(
                  children: [
                    CustomButton.elevatedButton(
                      "Add Land",
                      () {
                        navigate(context, const AddLandScreen());
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => vSizedBox2,
                        itemCount: _.landData.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: AppColors.kContainerShadeColor,
                              border: Border.all(color: AppColors.kBorderColor),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomNetworkImage(
                                  imageUrl:
                                      "https://img.freepik.com/free-vector/image-upload-concept-illustration_23-2148276163.jpg?size=338&ext=jpg",
                                ),
                                hSizedBox2,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText.ourText(
                                          _.landData.results?[index].district),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "Id: ${_.landData.results?[index].id}"),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "Parcel Id: ${_.landData.results?[index].parcelId}"),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "Area: ${_.landData.results?[index].area}"),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "Location: ${_.landData.results?[index].address}, ${_.landData.results?[index].city}"),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "Price: NPR. ${_.landData.results?[index].landPrice}"),
                                      vSizedBox1,
                                      CustomText.ourText(
                                          "status: ${_.landData.results?[index].isVerified}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
