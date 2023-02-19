import 'package:flutter/material.dart';
import '../../../../Data/Models/ArticlesLikesModel.dart';
import '../../../../Data/Models/ArticlesModel.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../Styles/colors.dart';
import '../../../Views/doctor_article_card_widget.dart';

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
              DoctorArticleCard(
                article: articles[i],
              ),
          ],
        ),
      )),
    );
  }
}
