import 'package:cloud_firestore/cloud_firestore.dart';

class MovieModel {
  String? id;
  String? name;
  String? director;
  String? imgUrl;
  String? userId;

  MovieModel(this.id, this.name, this.director, this.imgUrl, this.userId);

  MovieModel.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.get('id');
    name = snapshot.get('name');
    director = snapshot.get('director');
    imgUrl = snapshot.get('img_url');
    userId = snapshot.get('user_id');
  }
}
