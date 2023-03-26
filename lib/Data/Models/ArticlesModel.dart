import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import '../../Presentation/Widgets/loading_widget.dart';

class Article {
  var articleId;
  var doctorId;
  var doctorName;
  var doctorImage;
  var doctorField;
  var content;
  var likes;
  var dislikes;

  Article({
    this.articleId,
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
  }).then((value) {
    if (article.content.length > 16) {
      article.content = article.content.substring(0, 15) + "..";
    }
    SendNotifyToTopic('New Article was added "${article.content}"');
  });
  Navigator.pop(context);
  return "Added";
}

GetAllArticles() async {
  List<Article> articles = [];
  await FirebaseFirestore.instance.collection("Articles").get().then((value) {
    for (var art in value.docs) {
      Article a = Article(
          articleId: art.id,
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

AddLikeToArticle(articleId) async {
  var articleContent, userToken, userId;
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) async {
    var like;
    articleContent = value.data()!["Content"];
    userId = value.data()!["DoctorId"];
    if (value.data()!["Likes"] == 0) {
      like = 1;
    } else {
      like = value.data()!["Likes"] + 1;
    }
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(value.id)
        .update({"Likes": like});
  }).then((value) async {
    await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(userId)
        .get()
        .then((value) => userToken = value.data()!["Token"]);
    SendNotifyToUser(
        'Someone Likes your article "${articleContent.substring(0, 15)}..."',
        userToken,
        userId);
  });
}

DeleteLikeFromArticle(articleId) async {
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) async {
    var like;
    if (value.data()!["Likes"] == 0) {
      like = 0;
    } else {
      like = value.data()!["Likes"] - 1;
    }
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(value.id)
        .update({"Likes": like});
  });
}

AddDislikeToArticle(articleId) async {
  var articleContent, userToken, userId;
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) async {
    var dislike;
    articleContent = value.data()!["Content"];
    userId = value.data()!["DoctorId"];
    if (value.data()!["Dislikes"] == 0) {
      dislike = 1;
    } else {
      dislike = value.data()!["Dislikes"] + 1;
    }
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(value.id)
        .update({"Dislikes": dislike});
  }).then((value) async {
    await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(userId)
        .get()
        .then((value) => userToken = value.data()!["Token"]);
    SendNotifyToUser(
        'Someone dislikes your article "${articleContent.substring(0, 15)}..."',
        userToken,
        userId);
  });
}

DeleteDislikeFromArticle(articleId) async {
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) async {
    var dislike;
    if (value.data()!["Dislikes"] == 0) {
      dislike = 0;
    } else {
      dislike = value.data()!["Dislikes"] - 1;
    }
    await FirebaseFirestore.instance
        .collection("Articles")
        .doc(value.id)
        .update({"Dislikes": dislike});
  });
}

GetLikes(articleId) async {
  var likes = 0;
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) {
    likes = value.data()!["Likes"];
  });
  return likes;
}

GetDislikes(articleId) async {
  var dislikes = 0;
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .get()
      .then((value) {
    dislikes = value.data()!["Dislikes"];
  });
  return dislikes;
}

GetSpecificDoctorArticles(doctorId) async {
  List<Article> articles = [];
  await FirebaseFirestore.instance
      .collection("Articles")
      .where("DoctorId", isEqualTo: doctorId)
      .get()
      .then((value) {
    for (var art in value.docs) {
      Article a = Article(
          articleId: art.id,
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

DeleteArticle({articleId, context, userId, content, role}) async {
  var userToken;
  await FirebaseFirestore.instance
      .collection("Articles")
      .doc(articleId)
      .delete()
      .then((value) async {
    if (role == "admin") {
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(userId)
          .get()
          .then((value) => userToken = value.data()!["Token"]);

      if (content.length > 16) {
        content = content.substring(0, 15) + "..";
      }
      SendNotifyToUser(
          'The Admin deleted your article "${content}"', userToken!, userId!);
    }
  });
  Navigator.pop(context);
  return "deleted";
}

GetArticlesNb(doctorId) async {
  var number;
  await FirebaseFirestore.instance
      .collection("Articles")
      .where("DoctorId", isEqualTo: doctorId)
      .get()
      .then((value) {
    number = value.size;
  });
  return number;
}
