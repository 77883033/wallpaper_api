

import 'package:get/get.dart';
import 'package:wallpaper_api/modelClass.dart';
import 'package:wallpaper_api/service.dart';

class HomeViewModel extends GetxController {
  bool isLoading = false;
  Map<String, List<WallpaperModel>> wallpapers = {};

  vmGetwallpaperData(String category) async {
    isLoading = true;
    update();
    wallpapers[category] =
    await WallpaperService().fetchWallpaperData(category);
    isLoading = false;
    update();
  }

  List<WallpaperModel> vmWallpapers(String category) {
    return wallpapers[category] ?? [];
  }
}
