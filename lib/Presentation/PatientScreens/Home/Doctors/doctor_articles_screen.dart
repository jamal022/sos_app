import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../Data/Models/ArticlesLikesModel.dart';
import '../../../../Data/Models/ArticlesModel.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../DoctorScreens/Home/Articles/specific_article_screen.dart';
import '../../../Styles/colors.dart';

class DoctotArticlesScreen extends StatefulWidget {
  Doctor doctor;
  DoctotArticlesScreen({super.key, required this.doctor});

  @override
  State<DoctotArticlesScreen> createState() => _DoctotArticlesScreenState();
}

class _DoctotArticlesScreenState extends State<DoctotArticlesScreen> {
  List<Article> articles = [];
  List<ArticleLikes> likes = [];
  _getArticles() async {
    articles = await GetSpecificDoctorArticles(widget.doctor.id);
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
        title: Text(widget.doctor.username,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
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
                                  backgroundImage:
                                      NetworkImage(articles[i].doctorImage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  radius: 35,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('  ${articles[i].doctorName}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text('  ${articles[i].doctorField}',
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
                                  "${articles[i].likes}",
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
                                  "${articles[i].dislikes}",
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
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'See Details',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 24, 111, 183)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SpecificArticleScreen(
                                                    article: articles[i],
                                                  )),
                                        );
                                        if (result == "refresh") {
                                          _getArticles();
                                        }
                                      }),
                              ],
                            ),
                          ),
                        ]),
                      ])))
          ],
        ),
      )),
    );
  }
}
