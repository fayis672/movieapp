import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:movie_app/model/movie_model.dart';

class MovieController extends GetxController {
  final CollectionReference _movieRef =
      FirebaseFirestore.instance.collection('movie');
  final firebase_storage.Reference _posterRef =
      firebase_storage.FirebaseStorage.instance.ref().child('food_img');
  var movieList = <MovieModel?>[].obs;
  var posterUrl = ''.obs;

  @override
  void onInit() {
    movieList.bindStream(getMovies());
    super.onInit();
  }

  Future<void> addMovie(MovieModel movie, File file) async {
    var id = Timestamp.now().nanoseconds.toString();
    //loading.value = true
    await _posterRef.child(id + ".jpg").putFile(file).then((value) async {
      posterUrl.value = await value.ref.getDownloadURL();
      await _movieRef
          .add({
            'id': id,
            'name': movie.name,
            'director': movie.director,
            'img_url': posterUrl.value,
            'user_id': movie.userId
          })
          .then((value) {})
          .catchError((error) {
            Get.snackbar('Failed', error.toString());
          });
    }).catchError((e) {
      Get.snackbar(' Image uploading Failed', e.toString());
    });
  }

  Stream<List<MovieModel>> getMovies() {
    Stream<QuerySnapshot> stream = _movieRef.snapshots();
    return stream.map((snapshot) => snapshot.docs.map((snap) {
          return MovieModel.fromQuerySnapshot(snap);
        }).toList());
  }

  Future<void> deleteMovie(String id) async {
    var docId = '';
    await _movieRef.where('id', isEqualTo: id).get().then((snapshot) {
      for (var element in snapshot.docs) {
        docId = element.reference.id;
      }
    });
    await _movieRef.doc(docId).delete().then((value) async {
      await _posterRef.child(id + ".jpg").delete();
    }).catchError((e) {});
  }
}
