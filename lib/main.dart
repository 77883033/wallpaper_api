import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_api/details.dart';
import 'package:wallpaper_api/fullScreen.dart';
import 'package:wallpaper_api/splashscreen.dart';
import 'package:wallpaper_api/wallpaperPage.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/splash", page: ()=>SplashScreen()),
        GetPage(name: "/page1", page: ()=>WallpaperPage()),
        GetPage(name: "/page2", page: ()=>WallpaperDescription()),
        GetPage(name: "/page3", page: ()=>FullscreenPage()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
