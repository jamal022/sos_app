import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/AnswerModel.dart';
import '../../../../Data/Models/QuestionModel.dart';
import '../../../Styles/colors.dart';

class SpecificQuestionScreen extends StatefulWidget {
  Question question;
  SpecificQuestionScreen({super.key, required this.question});

  @override
  State<SpecificQuestionScreen> createState() => _SpecificQuestionScreenState();
}

TextEditingController answerController = new TextEditingController();

class _SpecificQuestionScreenState extends State<SpecificQuestionScreen> {
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
    // TODO: implement initState
    super.initState();
    _getAnswers();
    _getAnswersCount();
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
        title: Text(widget.question.patientName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
                                backgroundImage:
                                    NetworkImage(widget.question.patientImage),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                radius: 30,
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('  ${widget.question.patientName}',
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    Text(' ${widget.question.date}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                153, 58, 58, 58))),
                                  ]),
                              const Spacer(),
                              Container(
                                color: const Color.fromARGB(255, 242, 235, 235),
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
                          thickness: 2.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: answerController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  var id, name, image, role;
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  id = prefs.getString("Id");
                                  image = prefs.getString("Image");
                                  role = prefs.getString("Role");
                                  name = prefs.getString("FullName");
                                  Answer answer = Answer(
                                      questionId: widget.question.questionId,
                                      userId: id,
                                      UserName: name,
                                      userImage: image,
                                      content: answerController.text,
                                      role: role);
                                  var result = await AddAnswer(answer, context);
                                  if (result == "Added") {
                                    _getAnswers();
                                    answerController.clear();
                                    _getAnswersCount();
                                  }
                                },
                                icon: const Icon(
                                  Icons.send,
                                  size: 24,
                                  color: Color.fromARGB(153, 58, 58, 58),
                                )),
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Write Your Answer...",
                            prefixIcon:
                                const Icon(Icons.question_answer, color: black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (var i = 0; i < answers.length; i++)
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white60,
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(answers[i].userImage),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        radius: 30,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('  ${answers[i].UserName}',
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(' ${answers[i].role}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        153, 58, 58, 58))),
                                          ]),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    color: const Color.fromARGB(
                                        255, 242, 235, 235),
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        answers[i].content,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(153, 58, 58, 58),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
