import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final storage = GetIt.I<FlutterSecureStorage>();
    navigate(context, storage);


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
                      Navigator.of(context).pushNamed("/register");
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
                      final token = await storage.read(key: TOKEN_KEY);
                      if (token != null) {
                        Navigator.of(context).pushNamed("/success");
                      } else {
                        Navigator.of(context).pushNamed("/login");
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

  void navigate(BuildContext context, FlutterSecureStorage storage) async {
    final token = await storage.read(key: TOKEN_KEY);
    if (token != null) {
      Navigator.of(context).pushNamedAndRemoveUntil("/profile", (r)=>false);
    }
  }
}
