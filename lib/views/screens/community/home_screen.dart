
import 'package:empower_u/views/screens/community/compose.dart';
import 'package:empower_u/views/screens/community/create_community_popup.dart';
import 'package:empower_u/views/widgets/tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/community_controller.dart';
import '../../constants/strings.dart';
import '../../widgets/appbar.dart';
import '../../widgets/drawer.dart';
import '../../widgets/tabbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,required this.username}) : super(key: key);

  final String username;
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),

          backgroundColor: bgColor,
          body: Column(
              children: [
                appbar(scaffoldKey),
                Expanded(
                  child: Row(
                    children: [
                      tabbar(),
                      tabbarview(username)
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}


