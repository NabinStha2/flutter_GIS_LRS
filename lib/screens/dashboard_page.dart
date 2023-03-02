import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/routing/route_name.dart';
import 'package:gis_flutter_frontend/core/routing/route_navigation.dart';
import 'package:gis_flutter_frontend/providers/user_provider.dart';
import 'package:gis_flutter_frontend/widgets/custom_circular_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../core/app/dimensions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_network_image_widget.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer_widget.dart';

GlobalKey<ScaffoldState> scKey = GlobalKey<ScaffoldState>();

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<UserProvider>(context, listen: false).getUser(ctx: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.ourText("Dashboard"),
      ),
      drawerEdgeDragWidth: 150,
      drawerEnableOpenDragGesture: true,
      drawer: DrawerWidget(
        scKey: scKey,
      ),
      body: Consumer<UserProvider>(
        builder: (context, _, child) => _.isLoading
            ? const CustomCircularProgressIndicatorWidget(
                title: "Loading user profile...",
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton.textButton(
                      "Edit Profile",
                      () {
                        navigateNamed(context, RouteName.editProfileRouteName);
                      },
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _.userData.imageFile?.imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomNetworkImage(
                                  imageUrl: _.userData.imageFile?.imageUrl,
                                ),
                              )
                            : const SizedBox(
                                height: 100,
                                width: 100,
                                child: Icon(Icons.person),
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.ourText(
                              _.userData.name ?? "",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            vSizedBox2,
                            CustomText.ourText(
                              _.userData.email ?? "",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            vSizedBox2,
                            CustomText.ourText(
                              _.userData.phoneNumber ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            vSizedBox2,
                            CustomText.ourText(
                              _.userData.address ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            vSizedBox2,
                          ],
                        ),
                      ],
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText.ourText(
                                  "Front Citizenship Document",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                vSizedBox1,
                                CustomNetworkImage(
                                  imageUrl: _.userData.frontCitizenshipFile
                                      ?.frontCitizenshipImage,
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(color: Colors.grey, width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText.ourText(
                                  "Back Citizenship Document",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                vSizedBox1,
                                CustomNetworkImage(
                                  imageUrl: _.userData.backCitizenshipFile
                                      ?.backCitizenshipImage,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
