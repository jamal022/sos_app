import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Presentation/Widgets/loading_widget.dart';

class Article {
  var doctorId;
  var doctorName;
  var doctorImage;
  var doctorField;
  var content;
  var likes;
  var dislikes;

  Article({
    required this.doctorId,
    required this.doctorName,
    required this.doctorField,
    required this.doctorImage,
    required this.content,
    required this.likes,
    required this.dislikes,
  });
}

AddArticle(Article article, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Articles").add({
    "DoctorId": article.doctorId,
    "DoctorName": article.doctorName,
    "DoctorField": article.doctorField,
    "DoctorImage": article.doctorImage,
    "Content": article.content,
    "Likes": article.likes,
    "Dislikes": article.dislikes,
  }).then((value) => Navigator.pop(context));
  return "Added";
}

GetAllArticles() async {
  List<Article> articles = [];
  await FirebaseFirestore.instance.collection("Articles").get().then((value) {
    for (var art in value.docs) {
      Article a = Article(
          doctorId: art.data()["DoctorId"],
          doctorName: art.data()["DoctorName"],
          doctorImage: art.data()["DoctorImage"],
          doctorField: art.data()["DoctorField"],
          content: art.data()["Content"],
          likes: art.data()["Likes"],
          dislikes: art.data()["Dislikes"]);
      articles.add(a);
    }
  });
  return articles;
}
