import 'package:flutter/material.dart';
import 'package:flutter_profile/screens/main/main_screen.dart';

import 'components/heighlights.dart';
import 'components/home_banner.dart';
import 'components/my_projects.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      children: [
        HomeBanner(),
        HighLightsInfo(),
        MyProjects(),
       
      ],
    );
  }
}
