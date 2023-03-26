import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/QuestionModel.dart';
import 'package:sos_app/Presentation/AdminScreens/Community/admin_question_page.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';

class AdminCommunityScreen extends StatefulWidget {
  const AdminCommunityScreen({super.key});

  @override
  State<AdminCommunityScreen> createState() => _AdminCommunityScreenState();
}

class _AdminCommunityScreenState extends State<AdminCommunityScreen> {
  List<Question> questions = [];
  _getQuestions() async {
    questions = await GetAllQuestions();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: adminback,
        appBar: AppBar(
          backgroundColor: black,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text("Q/A Community",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: questions.length != 0
            ? SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
                child: Column(
                  children: [
                    for (var i = 0; i < questions.length; i++)
                      Card(
                          margin: const EdgeInsets.all(15),
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: containerColor,
                          child: InkWell(
                            highlightColor: hoverColor,
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminQuestionPage(
                                          question: questions[i],
                                        )),
                              );
                              if (result == "refresh") {
                                _getQuestions();
                              }
                            },
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
                                                questions[i].patientImage),
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
                                                    '  ${questions[i].patientName}',
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(' ${questions[i].date}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
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
                                                        "Are you sure, you want to delete this question?",
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
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      ctx);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        black,
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
                                                              child:
                                                                  MaterialButton(
                                                                elevation: 6.0,
                                                                color: Colors
                                                                    .redAccent,
                                                                onPressed:
                                                                    () async {
                                                                  var result = await DeleteQuestion(
                                                                      content: questions[
                                                                              i]
                                                                          .content,
                                                                      userId: questions[
                                                                              i]
                                                                          .patientId,
                                                                      questionId:
                                                                          questions[i]
                                                                              .questionId,
                                                                      context:
                                                                          context,
                                                                      role:
                                                                          "admin");
                                                                  if (result ==
                                                                      "deleted") {
                                                                    _getQuestions();
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
                                              icon: const Icon(Icons.delete)),
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
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color:
                                            Color.fromARGB(255, 242, 235, 235),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(7.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          questions[i].content,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 0.5,
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
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 242, 235, 235),
                                            child: Padding(
                                              padding: const EdgeInsets.all(.0),
                                              child: Text(
                                                "${questions[i].answers} Answers",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ])),
                          ))
                  ],
                ),
              ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
