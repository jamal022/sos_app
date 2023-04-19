import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ArticlesLikesModel.dart';
import 'package:sos_app/Presentation/DoctorScreens/Home/Articles/add_article_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

import '../../../../Data/Models/ArticlesModel.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List<ArticleLikes> articles = [];
  var id;
  bool _flag = false;
  _getArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("Id");
    articles = await GetArticlesWithLikes(id);
    _flag = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          onPressed: () async {
            var name, id, image, field;

            SharedPreferences prefs = await SharedPreferences.getInstance();
            name = prefs.getString("FullName");
            id = prefs.getString("Id");
            image = prefs.getString("Image");
            field = prefs.getString("Field");

            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewArticlesScreen(
                        field: field,
                        id: id,
                        image: image,
                        name: name,
                      )),
            );
            if (result == "refresh") {
              _getArticles();
            }
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
        ),
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('Articles',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: _flag == true
            ? articles.length != 0
                ? SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
                    child: Column(
                      children: [
                        for (var i = 0; i < articles.length; i++)
                          Card(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: containerColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 15),
                                child: Column(children: <Widget>[
                                  Container(
                                    width: size.width / 0.5,
                                    height: size.height / 8.4,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              articles[i].article!.doctorImage),
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          radius: 28,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '  ${articles[i].article!.doctorName}',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  '  ${articles[i].article!.doctorField}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          153, 58, 58, 58))),
                                            ]),
                                        const Spacer(),
                                        const Icon(
                                          Icons.thumb_up_alt_rounded,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${articles[i].article!.likes}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const VerticalDivider(
                                          color: Colors.grey,
                                          thickness: 2,
                                          endIndent: 30,
                                          indent: 30,
                                          width: 15,
                                        ),
                                        const Icon(
                                          Icons.thumb_down_alt_rounded,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${articles[i].article!.dislikes}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          width: size.width / 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    color: const Color.fromARGB(
                                        255, 242, 235, 235),
                                    child: Container(
                                      margin: const EdgeInsets.all(7.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        articles[i].article!.content,
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width / 3.0,
                                          height: size.height / 19,
                                          alignment: Alignment.bottomLeft,
                                          child: CupertinoButton(
                                            minSize: 20,
                                            padding: const EdgeInsets.all(
                                                0), // remove button padding
                                            color: CupertinoColors.white
                                                .withOpacity(
                                                    0), // use this to make default color to transparent
                                            child: Container(
                                              // wrap the text/widget using container
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal:
                                                          30), // add padding
                                              decoration: BoxDecoration(
                                                color: articles[i].like == 1
                                                    ? const Color.fromARGB(
                                                        255, 2, 106, 218)
                                                    : white,
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 0, 122, 255),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        50)), // radius as you wish
                                              ),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    size: 18,
                                                    CupertinoIcons
                                                        .hand_thumbsup_fill,
                                                    color:
                                                        CupertinoColors.black,
                                                  ),
                                                  Text(
                                                    " Like",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onPressed: () async {
                                              ArticleLikes l = ArticleLikes(
                                                  articleId:
                                                      articles[i].articleId,
                                                  userId: id,
                                                  like: 1);
                                              if (articles[i].like == 0 ||
                                                  articles[i].like == null) {
                                                var result = await AddLike(l);
                                                if (result == "added") {
                                                  _getArticles();
                                                }
                                              } else if (articles[i].like ==
                                                  1) {
                                                var result =
                                                    await DeleteLike(l);
                                                if (result == "deleted") {
                                                  _getArticles();
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: size.width / 3.0,
                                          height: size.height / 19,
                                          alignment: Alignment.bottomRight,
                                          child: CupertinoButton(
                                            minSize: 20,
                                            padding: const EdgeInsets.all(
                                                0), // remove button padding
                                            color: CupertinoColors.white
                                                .withOpacity(
                                                    0), // use this to make default color to transparent
                                            child: Container(
                                              // wrap the text/widget using container
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal:
                                                          20), // add padding
                                              decoration: BoxDecoration(
                                                color: articles[i].like == 0
                                                    ? const Color.fromRGBO(
                                                        255, 45, 85, 1)
                                                    : white,
                                                border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      255, 45, 85, 1),
                                                  width: 1,
                                                ),
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        50)), // radius as you wish
                                              ),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    size: 18,
                                                    CupertinoIcons
                                                        .hand_thumbsdown_fill,
                                                    color:
                                                        CupertinoColors.black,
                                                  ),
                                                  Text(
                                                    " DisLike",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: black),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onPressed: () async {
                                              ArticleLikes l = ArticleLikes(
                                                  articleId:
                                                      articles[i].articleId,
                                                  userId: id,
                                                  like: 0);
                                              if (articles[i].like == 1 ||
                                                  articles[i].like == null) {
                                                var result =
                                                    await AddDislike(l);
                                                if (result == "added") {
                                                  _getArticles();
                                                }
                                              } else if (articles[i].like ==
                                                  0) {
                                                var result =
                                                    await DeleteLike(l);
                                                if (result == "deleted") {
                                                  _getArticles();
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ]),
                                ]),
                              ))
                      ],
                    ),
                  ))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 100,
                          color: primaryColor,
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        const Text(
                          'There is no Articles',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
