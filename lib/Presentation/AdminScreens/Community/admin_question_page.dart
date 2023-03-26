import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/AnswerModel.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../../../Data/Models/QuestionModel.dart';

class AdminQuestionPage extends StatefulWidget {
  Question question;
  AdminQuestionPage({super.key, required this.question});

  @override
  State<AdminQuestionPage> createState() => _AdminQuestionPageState();
}

TextEditingController answerController = new TextEditingController();

class _AdminQuestionPageState extends State<AdminQuestionPage> {
  List<Answer> answers = [];
  var answersCount = 0;
  _getAnswers() async {
    answers = await GetQuestionAnswers(widget.question.questionId);
    setState(() {});
  }

  _getAnswersCount() async {
    answersCount = await GetAnswersCount(widget.question.questionId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAnswers();
    _getAnswersCount();
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
          title: Text(widget.question.patientName,
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, "refresh");
              }),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 80.0),
          child: Column(
            children: [
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
                                      widget.question.patientImage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  radius: 30,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('  ${widget.question.patientName}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text(' ${widget.question.date}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  153, 58, 58, 58))),
                                    ]),
                                const Spacer(),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 242, 235, 235),
                                  child: Text(
                                    "${answersCount} Answers",
                                    style: const TextStyle(fontSize: 16),
                                  ),
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
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Color.fromARGB(255, 242, 235, 235),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(7.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.question.content,
                                style: const TextStyle(
                                  fontSize: 18,
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
                          const Divider(
                            color: Color.fromARGB(153, 58, 58, 58),
                            thickness: 2,
                          ),
                          for (var i = 0; i < answers.length; i++)
                            Column(children: <Widget>[
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 8.0, 0),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  answers[i].userImage),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 255, 255),
                                              radius: 20,
                                            ),
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(" ${answers[i].UserName}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(answers[i].role,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            153, 58, 58, 58))),
                                              ]),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              useSafeArea: false,
                                              context: context,
                                              barrierColor: splashBack,
                                              builder: (ctx) => AlertDialog(
                                                content: const Text(
                                                    "Are you sure, you want to delete this answer?",
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
                                                              var result = await DeleteAnswer(
                                                                  content: answers[
                                                                          i]
                                                                      .content,
                                                                  userId:
                                                                      answers[i]
                                                                          .userId,
                                                                  userRole:
                                                                      answers[i]
                                                                          .role,
                                                                  questionId:
                                                                      answers[i]
                                                                          .questionId,
                                                                  answerId:
                                                                      answers[i]
                                                                          .answerId,
                                                                  context:
                                                                      context,
                                                                  role:
                                                                      "admin");
                                                              if (result ==
                                                                  "deleted") {
                                                                _getAnswers();
                                                                _getAnswersCount();
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
                                            size: 28,
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
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
                                          "${answers[i].content}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ]),
                        ]),
                      ])))
            ],
          ),
        )));
  }
}
