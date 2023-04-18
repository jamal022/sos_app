import 'package:cloud_firestore/cloud_firestore.dart';
import 'AnswerModel.dart';
import 'QuestionModel.dart';

class QuestionAnswer {
  Question? question;
  Answer? answer;

  QuestionAnswer({
    this.question,
    this.answer,
  });
}

GetAnswersWithQuestion(userId) async {
  List<QuestionAnswer> qaList = [];
  await FirebaseFirestore.instance
      .collection("Answers")
      .where("UserId", isEqualTo: userId)
      .get()
      .then((value) async {
    for (var answer in value.docs) {
      QuestionAnswer qa = QuestionAnswer();
      var name, image;
      if (answer.data()["Role"] == "Patient") {
        await FirebaseFirestore.instance
            .collection("Patients")
            .doc(answer.data()["UserId"])
            .get()
            .then((value) {
          name = value.data()!["FullName"];
          image = value.data()!["Image"];
        });
      } else if (answer.data()["Role"] == "Doctor") {
        await FirebaseFirestore.instance
            .collection("Doctors")
            .doc(answer.data()["UserId"])
            .get()
            .then((value) {
          name = value.data()!["FullName"];
          image = value.data()!["Image"];
        });
      }
      Answer a = Answer(
          answerId: answer.id,
          questionId: answer.data()["QuestionId"],
          userId: answer.data()["UserId"],
          UserName: name,
          userImage: image,
          content: answer.data()["Content"],
          role: answer.data()["Role"]);
      qa.answer = a;
      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(answer.data()["QuestionId"])
          .get()
          .then((value) async {
        Question question = Question(
            questionId: value.id,
            patientId: value.data()!["PatientId"],
            content: value.data()!["Content"],
            answers: value.data()!["Answers"],
            date: value.data()!["Date"]);
        var patientName, patientImage;
        await FirebaseFirestore.instance
            .collection("Patients")
            .doc(value.data()!["PatientId"])
            .get()
            .then((value) {
          patientName = value.data()!["FullName"];
          patientImage = value.data()!["Image"];
        });
        question.patientName = patientName;
        question.patientImage = patientImage;
        qa.question = question;
      });
      qaList.add(qa);
    }
  });
  return qaList;
}
