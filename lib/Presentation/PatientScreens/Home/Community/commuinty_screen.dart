import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Community/add_question_screen.dart';
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
      backgroundColor: back,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: const Text("Q/A Community",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
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
                                      NetworkImage(questions[i].patientImage),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  radius: 30,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('  ${questions[i].patientName}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      Text(' ${questions[i].date}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  153, 58, 58, 58))),
                                    ]),
                                const Spacer(),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 242, 235, 235),
                                  child: Padding(
                                    padding: const EdgeInsets.all(.0),
                                    child: Text(
                                      "${questions[i].answers} Answers",
                                      style: const TextStyle(fontSize: 16),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: const Color.fromARGB(255, 242, 235, 235),
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
                                                  SpecificQuestionScreen(
                                                    question: questions[i],
                                                  )),
                                        );
                                        if (result == "refresh") {
                                          _getQuestions();
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
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () async {
          var name, id, image;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          name = prefs.getString("FullName");
          id = prefs.getString("Id");
          image = prefs.getString("Image");

          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewQuestionScreen(
                      id: id,
                      image: image,
                      name: name,
                    )),
          );
          if (result == "refresh") {
            _getQuestions();
          }
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
