import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/controller/scroll_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final MovieController _movieController = Get.put(MovieController());
  final ScrollCont _scrollCont = Get.put(ScrollCont());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/details', arguments: index);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          _movieController.movieList[index]!.name ?? "Movie"),
                      subtitle: Text(
                          _movieController.movieList[index]!.director ??
                              "Director"),
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: Hero(
                          tag: "img" + index.toString(),
                          child: Image.network(
                            _movieController.movieList[index]!.imgUrl ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _movieController.deleteMovie(
                              _movieController.movieList[index]!.id!);
                        },
                      ),
                    ),
                  ),
                );
              },
              itemCount: _movieController.movieList.length,
            )),
      )),
      floatingActionButton: SizedBox(
        width: 150,
        child: Obx(() => AnimatedOpacity(
              opacity: _scrollCont.isScrollingDown.value ? 0 : 1,
              duration: const Duration(microseconds: 100),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.toNamed('/addMovie');
                },
                tooltip: "increment",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Text("Add movie"),
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
