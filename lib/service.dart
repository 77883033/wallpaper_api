import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_api/modelClass.dart';

class WallpaperService {
  final _baseUrl = "https://api.pexels.com/v1/";
  final _key = "yiwuOHdRRfQtI6x1WbkHESqI71onJ5vIw1Fd4bgFFbU8Ff87pM7OMUHD";

  // Fetch wallpapers based on category
  Future<List<WallpaperModel>> fetchWallpaperData(String category) async {
    try {
      final url = "${_baseUrl}search?query=${category}&per_page=35";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": _key,
      });

      // Check if the response is successful
      if (response.statusCode == 200) {
        final allData = jsonDecode(response.body);
        final List data = allData["photos"];
        return data.map((photos) => WallpaperModel.fromMap(photos)).toList();
      } else {
        throw Exception('Failed to fetch wallpapers');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Function to download photo
  Future<void> downloadPhoto(String imgUrl) async {
    final Uri _url = Uri.parse(imgUrl);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Search wallpapers based on query
  Future<List<WallpaperModel>> searchWallpapers(String query) async {
    try {
      final url = "${_baseUrl}search?query=${query}&per_page=35";
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": _key,
      });

      // Check if the response is successful
      if (response.statusCode == 200) {
        final allData = jsonDecode(response.body);
        final List data = allData["photos"];
        return data.map((photos) => WallpaperModel.fromMap(photos)).toList();
      } else {
        throw Exception('Failed to fetch search results');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
