import 'package:camera/camera.dart';
import 'package:empower_u/views/constants/firebase_constants.dart';
import 'package:empower_u/views/constants/strings.dart';
import 'package:empower_u/views/screens/root_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controllers/community_controller.dart';
// import 'package:alan_voice/alan_voice.dart';

List<CameraDescription> cameras=[];

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor:Colors.white,
        statusBarBrightness: Brightness.dark,
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Empower U',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
      initialBinding: BindingsBuilder(() {
        Get.put(CommunityController());
      }),
    );
  }
}


