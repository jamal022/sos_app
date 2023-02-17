import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';
import 'package:sos_app/Presentation/DoctorScreens/Home/Articles/add_article_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Views/doctor_article_card_widget.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
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
