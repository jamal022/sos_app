import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../../../../Data/Models/QuestionModel.dart';

class NewQuestionScreen extends StatefulWidget {
  var id;
  var name;
  var image;
  NewQuestionScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  State<NewQuestionScreen> createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends State<NewQuestionScreen> {
  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('New Question',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: Card(
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
                              backgroundImage: NetworkImage(widget.image),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              radius: 35,
                            ),
                            Text('  ${widget.name}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            color: Colors.white,
                          ),
                          child: Column(children: <Widget>[
                            TextField(
                              controller: contentController,
                              maxLines: 10,
                              minLines: 1,
                              decoration: const InputDecoration(
                                hintText: "Write new question...",
                                hintStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.mode_edit_outline_sharp,
                                  color: Colors.black,
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ])),
                      Container(
                          width: size.width / 0.8,
                          height: size.height / 12.4,
                          alignment: Alignment.bottomRight,
                          child: MaterialButton(
                              elevation: 6.0,
                              color: primaryColor,
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () async {
                                Question question = Question(
                                    answers: 0,
                                    content: contentController.text,
                                    date:
                                        "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
                                    patientId: widget.id,
                                    patientImage: widget.image,
                                    patientName: widget.name);

                                var result =
                                    await AddQuestion(question, context);
                                if (result == "Added") {
                                  Navigator.pop(context, "refresh");
                                }
                              },
                              child: const Text(
                                'Post',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ]),
                  ]),
                ))));
  }
}
