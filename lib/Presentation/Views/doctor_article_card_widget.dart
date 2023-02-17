import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';

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
                    child: Center(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Container(
                    width: size.width / 3.0,
                    height: size.height / 20.5,
                    alignment: Alignment.bottomLeft,
                    /*
                              child: MaterialButton(
                                  elevation: 6.0,
                                  color: primaryColor,
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Like',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                                  */
                    child: CupertinoButton(
                      minSize: 20,
                      padding: const EdgeInsets.all(0), // remove button padding
                      color: CupertinoColors.white.withOpacity(
                          0), // use this to make default color to transparent
                      child: Container(
                        // wrap the text/widget using container
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 30), // add padding
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 122, 255),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(50)), // radius as you wish
                        ),
                        child: Wrap(
                          children: const [
                            Icon(
                              size: 23,
                              CupertinoIcons.hand_thumbsdown_fill,
                              color: CupertinoColors.black,
                            ),
                            Text(
                              " Like",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: CupertinoColors.systemBlue),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        // on press action
                      },
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width / 3.0,
                    height: size.height / 20.5,
                    alignment: Alignment.bottomRight,
                    /*
                              child: MaterialButton(
                                  elevation: 6.0,
                                  color: primaryColor,
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Like',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                                  */
                    child: CupertinoButton(
                      minSize: 20,
                      padding: const EdgeInsets.all(0), // remove button padding
                      color: CupertinoColors.white.withOpacity(
                          0), // use this to make default color to transparent
                      child: Container(
                        // wrap the text/widget using container
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 20), // add padding
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(255, 45, 85, 1),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(50)), // radius as you wish
                        ),
                        child: Wrap(
                          children: const [
                            Icon(
                              size: 23,
                              CupertinoIcons.hand_thumbsup_fill,
                              color: CupertinoColors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              " DisLike",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: CupertinoColors.systemPink),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        // on press action
                      },
                    ),
                  ),
                ]),
              ]),
            ])));
  }
}
