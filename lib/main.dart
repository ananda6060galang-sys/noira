import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/controllers/library_controller.dart';
import 'app/controllers/navigation_controller.dart';
import 'app/controllers/player_controller.dart';
import 'app/controllers/queue_controller.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  Get.put(NavigationController(), permanent: true);
  Get.put(PlayerController(), permanent: true);
  Get.put(QueueController(), permanent: true);
  Get.put(LibraryController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noira',
      home: const SplashScreen(),
    );
  }
}
