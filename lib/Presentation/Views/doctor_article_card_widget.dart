import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';
import 'package:sos_app/Presentation/DoctorScreens/Home/Articles/specific_article_screen.dart';
import '../Styles/colors.dart';

class DoctorArticleCard extends StatefulWidget {
  Article article;
  DoctorArticleCard({super.key, required this.article});

  @override
  State<DoctorArticleCard> createState() => _DoctorArticleCardState();
}

class _DoctorArticleCardState extends State<DoctorArticleCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        margin: const EdgeInsets.all(15),
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('  ${widget.article.doctorField}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(153, 58, 58, 58))),
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
                        "${widget.article.likes}",
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
                        "${widget.article.dislikes}",
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
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'See Details',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 24, 111, 183)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              var result = Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpecificArticleScreen(
                                          article: widget.article,
                                        )),
                              );
                            }),
                    ],
                  ),
                ),
              ]),
            ])));
  }
}
