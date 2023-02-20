import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';

class ArticleLikes {
  var articleId;
  var userId;
  var like; // 1 (like)  -  0  (dislike)

  ArticleLikes({
    this.articleId,
    this.userId,
    this.like,
  });
}

AddLike(ArticleLikes likes) async {
  await FirebaseFirestore.instance
      .collection("ArticleLikes")
      .where("UserId", isEqualTo: likes.userId)
      .where("ArticleId", isEqualTo: likes.articleId)
      .get()
      .then((value) async {
    if (value.docs.isEmpty) {
      await FirebaseFirestore.instance.collection("ArticleLikes").add({
        "ArticleId": likes.articleId,
        "UserId": likes.userId,
        "Like": likes.like,
      });
    } else {
      await FirebaseFirestore.instance
          .collection("ArticleLikes")
          .doc(value.docs.first.id)
          .update({"Like": likes.like});
    }
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
