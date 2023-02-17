import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/ArticlesLikesModel.dart';
import '../../../Data/Models/ArticlesModel.dart';
import '../../Styles/colors.dart';
import '../../Views/doctor_article_card_widget.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List<Article> articles = [];
  List<ArticleLikes> likes = [];
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
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: const Text('Articles',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
        child: Column(
          children: [
            for (var i = 0; i < articles.length; i++)
              DoctorArticleCard(
                article: articles[i],
              ),
          ],
        ),
      )),
    );
  }
}
