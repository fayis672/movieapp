import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key}) : super(key: key);

  final MovieController _movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "img" + Get.arguments.toString(),
                    child: Image.network(
                      _movieController.movieList[Get.arguments]!.imgUrl ?? "",
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 5),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Movie Name: " +
                          (_movieController.movieList[Get.arguments]!.name ??
                              "Movie"),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Director: " +
                          (_movieController
                                  .movieList[Get.arguments]!.director ??
                              "Movie"),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const Text(
                      "Discription:This is a demo movie which shows many different movies as a list. the above mentioned movei is nive and good. ",
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
