import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper_api/modelClass.dart';
import 'package:wallpaper_api/service.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  List<Tab> categories = [
    Tab(text: "NATURE"),
    Tab(text: "FLOWER"),
    Tab(text: "CITY"),
    Tab(text: "ANIMALS"),
    Tab(text: "ARTS"),
    Tab(text: "CARTOONS"),
  ];

  String searchQuery = "";
  TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: !isSearching
              ? Text(
            "WALLPAPERS",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          )
              : TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Search Wallpapers...",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            onSubmitted: (query) {
              setState(() {
                searchQuery = query;
                isSearching = true;
              });
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search),
              color: Colors.yellow,
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    isSearching = false;
                    searchQuery = "";
                    _searchController.clear();
                  } else {
                    isSearching = true;
                  }
                });
              },
            ),
          ],
          bottom: isSearching
              ? null
              : TabBar(
            tabs: categories,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.yellow),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 0,
            dividerColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.red,
          ),
        ),
        body: isSearching
            ? searchResults()
            : TabBarView(
            children:
            categories.map((tab) => customGridView(tab)).toList()),
      ),
    );
  }

  FutureBuilder<List<WallpaperModel>> customGridView(Tab tab) {
    return FutureBuilder<List<WallpaperModel>>(
      future: WallpaperService().fetchWallpaperData(tab.text!.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No data found", style: TextStyle(color: Colors.white)));
        } else {
          return MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final photos = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed("/page2", arguments: photos);
                  },
                  child: Hero(
                    tag: photos.imgUrl,
                    child: Container(
                      height: (index % 3 + 2) * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(int.parse(
                            photos.avaColor.replaceAll("#", "0xff"))),
                        image: DecorationImage(
                            image: NetworkImage("${photos.imgUrl}"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

  FutureBuilder<List<WallpaperModel>> searchResults() {
    return FutureBuilder<List<WallpaperModel>>(
      future: WallpaperService().searchWallpapers(searchQuery.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No data found", style: TextStyle(color: Colors.white)));
        } else {
          return MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final photos = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed("/page2", arguments: photos);
                  },
                  child: Hero(
                    tag: photos.imgUrl,
                    child: Container(
                      height: (index % 3 + 2) * 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(int.parse(
                            photos.avaColor.replaceAll("#", "0xff"))),
                        image: DecorationImage(
                            image: NetworkImage("${photos.imgUrl}"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
