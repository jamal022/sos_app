import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';

class AdminArticlesScreen extends StatefulWidget {
  const AdminArticlesScreen({super.key});

  @override
  State<AdminArticlesScreen> createState() => _AdminArticlesScreenState();
}

class _AdminArticlesScreenState extends State<AdminArticlesScreen> {
  List<Article> articles = [];
  _getArticles() async {
    articles = await GetAllArticles();
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
        backgroundColor: adminback,
        appBar: AppBar(
          backgroundColor: black,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('Articles',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: articles.length != 0
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
                child: Column(
                  children: [
                    for (var i = 0; i < articles.length; i++)
                      Card(
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
                                        backgroundImage: NetworkImage(
                                            articles[i].doctorImage),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        radius: 28,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('  ${articles[i].doctorName}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('  ${articles[i].doctorField}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        153, 58, 58, 58))),
                                          ]),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              useSafeArea: false,
                                              context: context,
                                              barrierColor: splashBack,
                                              builder: (ctx) => AlertDialog(
                                                content: const Text(
                                                    "Are you sure, you want to delete this article?",
                                                    style: TextStyle(
                                                      fontSize: contentFont,
                                                    )),
                                                actions: [
                                                  Row(
                                                    children: [
                                                      //btn cancel
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  ctx);
                                                            },
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                color: black,
                                                                fontSize:
                                                                    contentFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: MaterialButton(
                                                            elevation: 6.0,
                                                            color: Colors
                                                                .redAccent,
                                                            onPressed:
                                                                () async {
                                                              var result = await DeleteArticle(
                                                                  articleId:
                                                                      articles[
                                                                              i]
                                                                          .articleId,
                                                                  context:
                                                                      context,
                                                                  content:
                                                                      articles[
                                                                              i]
                                                                          .content,
                                                                  role: "admin",
                                                                  userId: articles[
                                                                          i]
                                                                      .doctorId);
                                                              if (result ==
                                                                  "deleted") {
                                                                _getArticles();
                                                              }
                                                            },
                                                            child: const Text(
                                                              'Sure',
                                                              style: TextStyle(
                                                                color: white,
                                                                fontSize:
                                                                    contentFont,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  color:
                                      const Color.fromARGB(255, 242, 235, 235),
                                  child: Container(
                                    margin: const EdgeInsets.all(7.0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      articles[i].content,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.thumb_up_alt_rounded,
                                        size: 24,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${articles[i].likes}",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Icon(
                                        Icons.thumb_down_alt_rounded,
                                        size: 24,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${articles[i].dislikes}",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ])),
                      )
                  ],
                ),
              ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
