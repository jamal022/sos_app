import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Community/specific_question_screen.dart';
import '../../../../Data/Models/QuestionModel.dart';
import '../../../Constants/app_assets.dart';
import '../../../Styles/colors.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Question> questions = [];
  bool _flag = false;
  _getQuestions() async {
    questions = await GetAllQuestions();
    _flag = true;
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
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: const Text("Q/A Community",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: _flag == true
          ? questions.length != 0
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
                                borderRadius: BorderRadius.circular(10)),
                            color: containerColor,
                            child: InkWell(
                              highlightColor: hoverColor,
                              onTap: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SpecificQuestionScreen(
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
                                              radius: 28,
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      '  ${questions[i].patientName}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(' ${questions[i].date}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              153,
                                                              58,
                                                              58,
                                                              58))),
                                                ]),
                                            const Spacer(),
                                            Container(
                                              color: const Color.fromARGB(
                                                  255, 242, 235, 235),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(.0),
                                                child: Text(
                                                  "${questions[i].answers} Answers",
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: Color.fromARGB(
                                              255, 242, 235, 235),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.all(7.0),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            questions[i].content.length > 50
                                                ? "${questions[i].content.substring(0, 50)}.."
                                                : questions[i].content,
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
                                    ]),
                                  ])),
                            ))
                    ],
                  ),
                ))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
                      const Icon(
                        Icons.warning_amber_rounded,
                        size: 100,
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      const Text(
                        'There is no Questions',
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
            ),
    );
  }
}
