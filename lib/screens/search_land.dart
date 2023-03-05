import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/app/dimensions.dart';
import 'package:gis_flutter_frontend/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../core/app/colors.dart';
import '../model/land/land_request_model.dart';
import '../providers/land_provider.dart';
import '../widgets/custom_circular_progress_indicator.dart';
import '../widgets/custom_network_image_widget.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer_widget.dart';
import 'dashboard_page.dart';

class SearchLandScreen extends StatefulWidget {
  const SearchLandScreen({super.key});

  @override
  State<SearchLandScreen> createState() => _SearchLandScreenState();
}

class _SearchLandScreenState extends State<SearchLandScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<LandProvider>(context, listen: false).getAllSearchLands(
        context: context,
        landRequestModel: LandRequestModel(
          page: 1,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText.ourText("Search Land"),
        ),
        drawerEdgeDragWidth: 150,
        drawer: DrawerWidget(
          scKey: scKey,
        ),
        body: Consumer<LandProvider>(
          builder: (context, _, child) => Padding(
            padding: screenLeftRightPadding,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: "Search land by parcel Id...",
                  controller: _.searchLandController,
                  suffix: Icon(Icons.search),
                  onlyNumber: true,
                  isFromSearch: true,
                  onFieldSubmitted: (val) {
                    _.getAllSearchLands(
                        context: context,
                        landRequestModel: LandRequestModel(
                          page: 1,
                          search: val.trim(),
                        ));
                  },
                ),
                Expanded(
                  child: _.isLoading
                      ? const CustomCircularProgressIndicatorWidget(
                          title: "Loading lands...",
                        )
                      : _.getAllSearchLandMessage != null
                          ? Center(
                              child: CustomText.ourText(
                                  _.getAllSearchLandMessage,
                                  color: Colors.red),
                            )
                          : _.paginatedAllSearchLandResult?.isEmpty ?? false
                              ? Center(
                                  child: CustomText.ourText(
                                    "Empty",
                                  ),
                                )
                              : NotificationListener<ScrollUpdateNotification>(
                                  onNotification: (ScrollUpdateNotification
                                      scrollNotification) {
                                    if (scrollNotification.metrics.pixels ==
                                            scrollNotification
                                                .metrics.maxScrollExtent &&
                                        _.paginatedAllSearchLandResultPageNumber +
                                                1 <=
                                            _.paginatedAllSearchLandResultTotalPages) {
                                      _.getAllSearchLands(
                                          context: context,
                                          landRequestModel: LandRequestModel(
                                            page:
                                                _.paginatedAllSearchLandResultPageNumber +
                                                    1,
                                          ));
                                    }
                                    return true;
                                  },
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      _.clearPaginatedAllSearchLandValue();
                                      _.getAllSearchLands(
                                          context: context,
                                          landRequestModel: LandRequestModel(
                                            page: 1,
                                            search: _.searchLandController.text
                                                .trim(),
                                          ));
                                      await Future.delayed(
                                          const Duration(seconds: 1), () {});
                                    },
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
                                            separatorBuilder:
                                                (context, index) => vSizedBox2,
                                            itemCount:
                                                _.paginatedAllSearchLandResult
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
                                                      color: AppColors
                                                          .kBorderColor),
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
                                                              .paginatedAllSearchLandResult?[
                                                                  index]
                                                              .district),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "Id: ${_.paginatedAllSearchLandResult?[index].ownerUserId}"),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "Parcel Id: ${_.paginatedAllSearchLandResult?[index].parcelId}"),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "Area: ${_.paginatedAllSearchLandResult?[index].area}"),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "Location: ${_.paginatedAllSearchLandResult?[index].address}, ${_.paginatedAllSearchLandResult?[index].city}"),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "Price: NPR. ${_.paginatedAllSearchLandResult?[index].landPrice}"),
                                                          vSizedBox1,
                                                          CustomText.ourText(
                                                              "status: ${_.paginatedAllSearchLandResult?[index].isVerified}"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          vSizedBox1,
                                          _.paginatedAllSearchLandResultPageNumber <
                                                  _.paginatedAllSearchLandResultTotalPages
                                              ? Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 15),
                                                  child:
                                                      const CustomCircularProgressIndicatorWidget(
                                                    title:
                                                        "Loading Land, Please wait...",
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 15),
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
                                ),
                ),
              ],
            ),
          ),
        ));
  }
}
