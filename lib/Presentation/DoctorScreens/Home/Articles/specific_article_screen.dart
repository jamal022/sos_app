import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Data/Models/ArticlesLikesModel.dart';
import '../../../../Data/Models/ArticlesModel.dart';
import '../../../Styles/colors.dart';

class SpecificArticleScreen extends StatefulWidget {
  Article article;
  SpecificArticleScreen({super.key, required this.article});

  @override
  State<SpecificArticleScreen> createState() => _SpecificArticleScreenState();
}

class _SpecificArticleScreenState extends State<SpecificArticleScreen> {
  var like;
  var likesCount = 0, dislikesCount = 0;
  _getLike() async {
    like = await GetLike(
        articleId: widget.article.articleId,
        userId: FirebaseAuth.instance.currentUser!.uid);
    likesCount = await GetLikes(widget.article.articleId);
    dislikesCount = await GetDislikes(widget.article.articleId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLike();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: Text(widget.article.doctorName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "refresh");
            }),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
              child: Card(
                  margin: const EdgeInsets.all(15),
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: containerColor,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Stack(children: <Widget>[
                        Column(children: <Widget>[
                          Container(
                            width: size.width / 0.5,
                            height: size.height / 8.4,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.article.doctorImage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  radius: 35,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('  ${widget.article.doctorName}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text('  ${widget.article.doctorField}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  153, 58, 58, 58))),
                                    ]),
                                const Spacer(),
                                const Icon(
                                  Icons.thumb_up_alt_rounded,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${likesCount}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.thumb_down_alt_rounded,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${dislikesCount}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            color: const Color.fromARGB(255, 242, 235, 235),
                            child: Container(
                              margin: const EdgeInsets.all(7.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.article.content,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Container(
                              width: size.width / 3.0,
                              height: size.height / 20.5,
                              alignment: Alignment.bottomLeft,
                              child: CupertinoButton(
                                minSize: 20,
                                padding: const EdgeInsets.all(
                                    0), // remove button padding
                                color: CupertinoColors.white.withOpacity(
                                    0), // use this to make default color to transparent
                                child: Container(
                                  // wrap the text/widget using container
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 30), // add padding
                                  decoration: BoxDecoration(
                                    color: like == "like"
                                        ? Color.fromARGB(255, 2, 106, 218)
                                        : white,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 0, 122, 255),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            50)), // radius as you wish
                                  ),
                                  child: Wrap(
                                    children: const [
                                      Icon(
                                        size: 23,
                                        CupertinoIcons.hand_thumbsup_fill,
                                        color: CupertinoColors.black,
                                      ),
                                      Text(
                                        " Like",
                                        style: TextStyle(
                                            fontSize: 20, color: black),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () async {
                                  if (like == "dislike" || like == null) {
                                    ArticleLikes l = ArticleLikes(
                                        articleId: widget.article.articleId,
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        like: 1);
                                    var result = await AddLike(l);
                                    if (result == "added") {
                                      await AddLikeToArticle(
                                          widget.article.articleId);
                                      if (like == "dislike") {
                                        await DeleteDislikeFromArticle(
                                            widget.article.articleId);
                                      }
                                      _getLike();
                                    }
                                  } else if (like == "like") {
                                    ArticleLikes l = ArticleLikes(
                                      articleId: widget.article.articleId,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    var result = await DeleteLike(l);
                                    if (result == "deleted") {
                                      await DeleteLikeFromArticle(
                                          widget.article.articleId);
                                      _getLike();
                                    }
                                  }
                                },
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: size.width / 3.0,
                              height: size.height / 20.5,
                              alignment: Alignment.bottomRight,
                              child: CupertinoButton(
                                minSize: 20,
                                padding: const EdgeInsets.all(
                                    0), // remove button padding
                                color: CupertinoColors.white.withOpacity(
                                    0), // use this to make default color to transparent
                                child: Container(
                                  // wrap the text/widget using container
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 9,
                                      horizontal: 20), // add padding
                                  decoration: BoxDecoration(
                                    color: like == "dislike"
                                        ? const Color.fromRGBO(255, 45, 85, 1)
                                        : white,
                                    border: Border.all(
                                      color:
                                          const Color.fromRGBO(255, 45, 85, 1),
                                      width: 1,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            50)), // radius as you wish
                                  ),
                                  child: Wrap(
                                    children: const [
                                      Icon(
                                        size: 23,
                                        CupertinoIcons.hand_thumbsdown_fill,
                                        color: CupertinoColors.black,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        " DisLike",
                                        style: TextStyle(
                                            fontSize: 19, color: black),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () async {
                                  if (like == "like" || like == null) {
                                    ArticleLikes l = ArticleLikes(
                                        articleId: widget.article.articleId,
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        like: 0);
                                    var result = await AddLike(l);
                                    if (result == "added") {
                                      await AddDislikeToArticle(
                                          widget.article.articleId);
                                      if (like == "like") {
                                        await DeleteLikeFromArticle(
                                            widget.article.articleId);
                                      }
                                      _getLike();
                                    }
                                  } else if (like == "dislike") {
                                    ArticleLikes l = ArticleLikes(
                                      articleId: widget.article.articleId,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    var result = await DeleteLike(l);
                                    if (result == "deleted") {
                                      await DeleteDislikeFromArticle(
                                          widget.article.articleId);
                                      _getLike();
                                    }
                                  }
                                },
                              ),
                            ),
                          ]),
                        ]),
                      ]))))),
    );
  }
}
