import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/app/colors.dart';
import 'package:gis_flutter_frontend/core/development/console.dart';
import 'package:gis_flutter_frontend/core/routing/route_navigation.dart';
import 'package:gis_flutter_frontend/providers/land_provider.dart';
import 'package:gis_flutter_frontend/screens/add_land.dart';
import 'package:gis_flutter_frontend/widgets/custom_button.dart';
import 'package:gis_flutter_frontend/widgets/custom_circular_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../core/app/dimensions.dart';
import '../model/land/land_request_model.dart';
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

    Provider.of<LandProvider>(context, listen: false).getOwnedLands(
        context: context, landRequestModel: LandRequestModel(page: 1));
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
              : _.getLandMessage != null
                  ? Center(
                      child: CustomText.ourText(_.getLandMessage,
                          color: Colors.red),
                    )
                  : _.paginatedOwnedLandResult?.isEmpty ?? false
                      ? Center(
                          child: CustomText.ourText(
                            "Empty",
                          ),
                        )
                      : NotificationListener<ScrollUpdateNotification>(
                          onNotification:
                              (ScrollUpdateNotification scrollNotification) {
                            if (scrollNotification.metrics.pixels ==
                                    scrollNotification
                                        .metrics.maxScrollExtent &&
                                _.paginatedOwnedLandResultPageNumber + 1 <=
                                    _.paginatedOwnedLandResultTotalPages) {
                              _.getOwnedLands(
                                  context: context,
                                  landRequestModel: LandRequestModel(
                                    page: _.paginatedOwnedLandResultPageNumber +
                                        1,
                                  ));
                            }
                            return true;
                          },
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await Future.delayed(
                                  const Duration(seconds: 1), () {});
                              _.clearPaginatedOwnedLandValue();
                              _.getOwnedLands(
                                  context: context,
                                  landRequestModel: LandRequestModel(
                                    page: 1,
                                  ));
                            },
                            child: Column(
                              children: [
                                CustomButton.elevatedButton(
                                  "Add Land",
                                  () {
                                    navigate(context, const AddLandScreen());
                                  },
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    child: Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              vSizedBox2,
                                          itemCount: _.paginatedOwnedLandResult
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .kContainerShadeColor,
                                                border: Border.all(
                                                    color:
                                                        AppColors.kBorderColor),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const CustomNetworkImage(
                                                    imageUrl:
                                                        "https://img.freepik.com/free-vector/image-upload-concept-illustration_23-2148276163.jpg?size=338&ext=jpg",
                                                  ),
                                                  hSizedBox2,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText.ourText(_
                                                            .paginatedOwnedLandResult?[
                                                                index]
                                                            .district),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "Id: ${_.paginatedOwnedLandResult?[index].ownerUserId}"),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "Parcel Id: ${_.paginatedOwnedLandResult?[index].parcelId}"),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "Area: ${_.paginatedOwnedLandResult?[index].area}"),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "Location: ${_.paginatedOwnedLandResult?[index].address}, ${_.paginatedOwnedLandResult?[index].city}"),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "Price: NPR. ${_.paginatedOwnedLandResult?[index].landPrice}"),
                                                        vSizedBox1,
                                                        CustomText.ourText(
                                                            "status: ${_.paginatedOwnedLandResult?[index].isVerified}"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        vSizedBox1,
                                        _.paginatedOwnedLandResultPageNumber <
                                                _.paginatedOwnedLandResultTotalPages
                                            ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child:
                                                    const CustomCircularProgressIndicatorWidget(
                                                  title:
                                                      "Loading Land, Please wait...",
                                                ),
                                              )
                                            : Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: CustomText.ourText(
                                                  "No more Land to Load.",
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        vSizedBox2,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
        ),
      ),
    );
  }
}
