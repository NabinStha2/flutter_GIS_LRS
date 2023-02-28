// import 'package:flutter/material.dart';
// import 'package:gis_flutter_frontend/core/routing/route_name.dart';
// import 'package:gis_flutter_frontend/layout.dart';
// import 'package:gis_flutter_frontend/pages/dashboard_page.dart';
// import 'package:gis_flutter_frontend/pages/edit_profile_page.dart';
// import 'package:gis_flutter_frontend/pages/login_page.dart';

// import '../../pages/map_page.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case RouteName.rootRoute:
//       return _getPageRoute(const SiteLayout());
//     case RouteName.mapPageRoute:
//       return _getPageRoute(const MapPage());
//     case RouteName.loginRouteName:
//       return _getPageRoute(const LoginPage());
//     case RouteName.dashboardRouteName:
//       return _getPageRoute(const DashboardPage());
//     case RouteName.editProfileRouteName:
//       return _getPageRoute(const EditProfilePage());
//     default:
//       return _getPageRoute(const Center(child: Text("not found")));
//   }
// }

// PageRoute _getPageRoute(Widget child) {
//   return MaterialPageRoute(builder: (context) => child);
// }
