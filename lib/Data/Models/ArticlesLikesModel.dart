import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';

class ArticleLikes {
  var articleId;
  Article? article;
  var userId;
  var like; // 1 (like)  -  0  (dislike)

  ArticleLikes({
    this.articleId,
    this.article,
    this.userId,
    this.like,
  });
}

AddLike(ArticleLikes like) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("UserId", isEqualTo: like.userId)
      .where("ArticleId", isEqualTo: like.articleId)
      .get()
      .then((value) async {
    if (value.docs.isEmpty) {
      await FirebaseFirestore.instance.collection("ArticleLikes").add({
        "ArticleId": like.articleId,
        "UserId": like.userId,
        "Like": like.like,
      });
    } else {
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .doc(value.docs.first.id)
          .update({"Like": like.like});
      await DeleteDislikeFromArticle(like.articleId);
    }
    await AddLikeToArticle(like.articleId);
  });

  return "added";
}

AddDislike(ArticleLikes dislike) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("UserId", isEqualTo: dislike.userId)
      .where("ArticleId", isEqualTo: dislike.articleId)
      .get()
      .then((value) async {
    if (value.docs.isEmpty) {
      await FirebaseFirestore.instance.collection("ArticleLikes").add({
        "ArticleId": dislike.articleId,
        "UserId": dislike.userId,
        "Like": dislike.like,
      });
    } else {
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .doc(value.docs.first.id)
          .update({"Like": dislike.like});
      await DeleteLikeFromArticle(dislike.articleId);
    }
    await AddDislikeToArticle(dislike.articleId);
  });

  return "added";
}

DeleteLike(ArticleLikes likes) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("UserId", isEqualTo: likes.userId)
      .where("ArticleId", isEqualTo: likes.articleId)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("ArticleLikes")
        .doc(value.docs.first.id)
        .delete();
  });
  if (likes.like == 0) {
    DeleteDislikeFromArticle(likes.articleId);
  } else if (likes.like == 1) {
    DeleteLikeFromArticle(likes.articleId);
  }
  return "deleted";
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

//remove
GetLike({userId, articleId}) async {
  var like;
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("UserId", isEqualTo: userId)
      .where("ArticleId", isEqualTo: articleId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      if (value.docs.first.data()["Like"] == 1) {
        like = "like";
      } else if (value.docs.first.data()["Like"] == 0) {
        like = "dislike";
      }
    }
  });
  return like;
}

GetArticlesWithLikes(userId) async {
  List<ArticleLikes> articles = [];
  await FirebaseFirestore.instance
      .collection("Articles")
      .orderBy("Likes", descending: true)
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

      var like;
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .where("UserId", isEqualTo: userId)
          .where("ArticleId", isEqualTo: art.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
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
          article: a, like: like, articleId: art.id, userId: userId));
    }
  });
  return articles;
}
