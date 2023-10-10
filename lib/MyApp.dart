import 'package:flutter/material.dart';
import 'package:flutter_auth/navigation/navigation_manager.dart';
import 'package:flutter_auth/navigation/routes.dart';
import 'package:flutter_auth/theme/theme.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      navigatorKey: GetIt.I<NavigationManager>().key,
      routes: RoutesBuilder.routes,
      initialRoute: RouteNames.initial,
    );
  }
}