import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movie_app/view/pages/add_movie.dart';
import 'package:movie_app/view/pages/home.dart';
import 'package:movie_app/view/pages/movie_details.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Home(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => Home()),
        GetPage(
          name: '/addMovie',
          page: () => AddMovie(),
        ),
        GetPage(
          name: '/details',
          page: () => MovieDetails(),
        ),
      ],
    );
  }
}
