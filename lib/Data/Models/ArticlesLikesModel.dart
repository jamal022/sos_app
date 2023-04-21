import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';

class ArticleLikes {
  var likeId;
  var articleId;
  Article? article;
  var userId;
  var like; // 1 (like)  -  0  (dislike)

  ArticleLikes({
    this.likeId,
    this.articleId,
    this.article,
    this.userId,
    this.like,
  });
}

AddLike(ArticleLikes like) async {
  await FirebaseFirestore.instance.collection("ArticleLikes").add({
    "ArticleId": like.articleId,
    "UserId": like.userId,
    "Like": like.like,
  }).then((value) async {
    await AddLikeToArticle(like.articleId);
  });
  return "done";
}

AddDislike(ArticleLikes dislike) async {
  await FirebaseFirestore.instance.collection("ArticleLikes").add({
    "ArticleId": dislike.articleId,
    "UserId": dislike.userId,
    "Like": dislike.like,
  }).then((value) async {
    await AddDislikeToArticle(dislike.articleId);
  });
  return "done";
}

DeleteLike(ArticleLikes like) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .doc(like.likeId)
      .delete()
      .then((value) async {
    await DeleteLikeFromArticle(like.articleId);
  });
  return "done";
}

DeleteDislike(ArticleLikes dislike) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .doc(dislike.likeId)
      .delete()
      .then((value) async {
    await DeleteDislikeFromArticle(dislike.articleId);
  });
  return "done";
}

UpdateLike(ArticleLikes like) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .doc(like.likeId)
      .update({"Like": like.like}).then((value) async {
    if (like.like == 0) {
      await DeleteLikeFromArticle(like.articleId);
      await AddDislikeToArticle(like.articleId);
    } else if (like.like == 1) {
      await DeleteDislikeFromArticle(like.articleId);
      await AddLikeToArticle(like.articleId);
    }
  });
  return "done";
}

DeleteAllArticleLikes(articleId) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("ArticleId", isEqualTo: articleId)
      .get()
      .then((value) async {
    for (var like in value.docs) {
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .doc(like.id)
          .delete();
    }
  });
  return "deleted";
}

GetArticlesWithLikes(userId) async {
  List<ArticleLikes> articles = [];
  await FirebaseFirestore.instance
      .collection("Articles")
      .get()
      .then((value) async {
    for (var art in value.docs) {
      var name, field, image;
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(art.data()["DoctorId"])
          .get()
          .then((value) {
        name = value.data()!["FullName"];
        image = value.data()!["Image"];
        field = value.data()!["Field"];
      });

      var like, likeId;
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .where("UserId", isEqualTo: userId)
          .where("ArticleId", isEqualTo: art.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          likeId = value.docs.first.id;
          like = value.docs.first.data()["Like"];
        } else {
          like = null;
        }
      });
      Article a = Article(
          articleId: art.id,
          doctorId: art.data()["DoctorId"],
          doctorField: field,
          doctorImage: image,
          doctorName: name,
          content: art.data()["Content"],
          likes: art.data()["Likes"],
          dislikes: art.data()["Dislikes"]);
      articles.add(ArticleLikes(
          likeId: likeId,
          article: a,
          like: like,
          articleId: art.id,
          userId: userId));
    }
  });
  return articles;
}

GetSpecificDoctorArticlesWithLikes(userId, doctorId) async {
  List<ArticleLikes> articles = [];
  await FirebaseFirestore.instance
      .collection("Articles")
      .where("DoctorId", isEqualTo: doctorId)
      .get()
      .then((value) async {
    for (var art in value.docs) {
      var name, field, image;
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(art.data()["DoctorId"])
          .get()
          .then((value) {
        name = value.data()!["FullName"];
        image = value.data()!["Image"];
        field = value.data()!["Field"];
      });

      var like, likeId;
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .where("UserId", isEqualTo: userId)
          .where("ArticleId", isEqualTo: art.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          likeId = value.docs.first.id;
          like = value.docs.first.data()["Like"];
        } else {
          like = null;
        }
      });
      Article a = Article(
          articleId: art.id,
          doctorId: art.data()["DoctorId"],
          doctorField: field,
          doctorImage: image,
          doctorName: name,
          content: art.data()["Content"],
          likes: art.data()["Likes"],
          dislikes: art.data()["Dislikes"]);
      articles.add(ArticleLikes(
          likeId: likeId,
          article: a,
          like: like,
          articleId: art.id,
          userId: userId));
    }
  });
  return articles;
}
