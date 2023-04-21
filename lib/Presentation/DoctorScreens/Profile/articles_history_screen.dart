import 'package:flutter/material.dart';
import '../../../Data/Models/ArticlesLikesModel.dart';
import '../../../Data/Models/ArticlesModel.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class ArticlesHistoryScreen extends StatefulWidget {
  Doctor doctor;
  ArticlesHistoryScreen({super.key, required this.doctor});

  @override
  State<ArticlesHistoryScreen> createState() => _ArticlesHistoryScreenState();
}

class _ArticlesHistoryScreenState extends State<ArticlesHistoryScreen> {
  List<Article> articles = [];
  bool _flag = false;
  _getArticles() async {
    articles = await GetSpecificDoctorArticles(widget.doctor.id);
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
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text("Articles History",
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
                                                  widget.doctor.image),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 255, 255),
                                              radius: 30,
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      '  ${widget.doctor.username}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      '  ${widget.doctor.field}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              153,
                                                              58,
                                                              58,
                                                              58))),
                                                ]),
                                            const Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, 5.0),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    useSafeArea: false,
                                                    context: context,
                                                    barrierColor: splashBack,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      content: const Text(
                                                          "Are you sure, you want to delete this article?",
                                                          style: TextStyle(
                                                            fontSize:
                                                                contentFont,
                                                          )),
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            //btn cancel
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .pop(
                                                                            ctx);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Cancel",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          primaryColor,
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
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    MaterialButton(
                                                                  elevation:
                                                                      6.0,
                                                                  color: Colors
                                                                      .redAccent,
                                                                  onPressed:
                                                                      () async {
                                                                    var res = await DeleteAllArticleLikes(
                                                                        articles[i]
                                                                            .articleId);
                                                                    if (res ==
                                                                        "deleted") {
                                                                      var result = await DeleteArticle(
                                                                          articleId: articles[i]
                                                                              .articleId,
                                                                          context:
                                                                              context);
                                                                      if (result ==
                                                                          "deleted") {
                                                                        _getArticles();
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Sure',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          white,
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        color: const Color.fromARGB(
                                            255, 242, 235, 235),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 5.0, 0.0, 5.0),
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
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ])))
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
