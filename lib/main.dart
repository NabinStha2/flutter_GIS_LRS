import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gis_flutter_frontend/providers/auth_provider.dart';
import 'package:gis_flutter_frontend/providers/map_provider.dart';
import 'package:gis_flutter_frontend/providers/user_provider.dart';
import 'package:gis_flutter_frontend/utils/app_shared_preferences.dart';
import 'package:gis_flutter_frontend/utils/global_context_service.dart';
import 'package:provider/provider.dart';

import 'core/routing/route_generator.dart';

// import 'package:flutter_web_plugins/url_strategy.dart';

Position? currentPosition;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  currentPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // usePathUrlStrategy();

  await AppSharedPreferences.sharedPrefInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapProvider>(create: (_) => MapProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
         routerConfig: RouteGenerator.goRouter,
        // routerDelegate: RouteGenerator.goRouter.routerDelegate,
        // routeInformationParser: RouteGenerator.goRouter.routeInformationParser,
        // routeInformationProvider: RouteGenerator.goRouter.routeInformationProvider,
        // initialRoute: AppSharedPreferences.getRememberMe ? RouteName.rootRoute : RouteName.loginRouteName,
        debugShowCheckedModeBanner: false,
        title: 'GIS LRS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // pageTransitionsTheme: const PageTransitionsTheme(builders: {
          //   TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          //   TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          // }),
        ),
        // home:AppSharedPreferences.getRememberMe ? LoginPage(): const SiteLayout(),
      ),
    );
  }
}
