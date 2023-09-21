import 'package:flutter/material.dart';
import 'package:flutter_auth/features/register_screen/register_screen.dart';
import 'package:flutter_auth/router/routes.dart';
import 'package:flutter_auth/theme/theme.dart';

import 'main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      routes: routes,
    );
  }
}