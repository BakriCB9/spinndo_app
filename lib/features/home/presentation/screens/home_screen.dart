import 'package:flutter/material.dart';

import '../../../drawer/presentation/screens/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName ='/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      drawer:  CustomDrawer(),

    );
  }
}