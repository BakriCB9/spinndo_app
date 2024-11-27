import 'package:flutter/material.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/main.dart';

import '../../../drawer/presentation/screens/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Replace this with your shared preference or token-check logic
                final String? token =
                    sharedPref.getString(CacheConstant.tokenKey);

                if (token == null) {
                  UIUtils.showMessage("You have to Sign in first");
                } else {
                  // Open the drawer
                  Scaffold.of(context).openDrawer();
                }
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: const Center(
        child: Text("Home Screen Content"),
      ),
    );
  }
}
