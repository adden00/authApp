import 'package:flutter/material.dart';
import 'package:flutter_auth/common/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'navigation/navigation_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final storage = GetIt.I<FlutterSecureStorage>();
  final navManager = GetIt.I<NavigationManager>();

  @override
  void didChangeDependencies() {
    trySignIn(context, storage);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Authentication"))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 100,
            ),
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      navManager.navToRegister();
                    },
                    child: const Text("register")),
                Container(
                  width: 10,
                ),
                TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () async {
                      final token = await storage.read(key: Constants.TOKEN_KEY);
                      if (token != null) {
                        navManager.navToProfile();
                      } else {
                        navManager.navToLogin();
                      }
                    },
                    child: const Text("log in"))
              ],
            )
          ],
        ),
      ),
    );
  }

  void trySignIn(BuildContext context, FlutterSecureStorage storage) async {
    final token = await storage.read(key: Constants.TOKEN_KEY);
    if (token != null) {
      navManager.navToProfile();
    }
  }
}
