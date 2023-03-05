import 'package:flutter/material.dart';
import 'package:gis_flutter_frontend/core/routing/route_navigation.dart';
import 'package:gis_flutter_frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../core/app/colors.dart';
import '../core/app/dimensions.dart';
import '../core/routing/route_name.dart';
import '../providers/user_provider.dart';

class DrawerWidget extends StatelessWidget {
  final bool? isFromDetails;
  final GlobalKey<ScaffoldState> scKey;
  const DrawerWidget({
    Key? key,
    this.isFromDetails = false,
    required this.scKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      width: appWidth(context) * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor2,
            ),
            child: Consumer<UserProvider>(
              builder: (context, _, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(_.userData.imageFile?.imageUrl ?? ""),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _.userData.name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _.userData.email ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              navigateOffAllNamed(context, RouteName.dashboardRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Map'),
            onTap: () {
              navigateOffAllNamed(context, RouteName.mapPageRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.landscape),
            title: const Text('Land'),
            onTap: () {
              navigateOffAllNamed(context, RouteName.landRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search Land'),
            onTap: () {
              navigateOffAllNamed(context, RouteName.searchLandRouteName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              Provider.of<AuthProvider>(context, listen: false)
                  .logout(ctx: context);
            },
          ),
        ],
      ),
    );
  }
}
