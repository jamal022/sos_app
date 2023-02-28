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
      Answer a = Answer(
          answerId: answer.id,
          questionId: answer.data()["QuestionId"],
          userId: answer.data()["UserId"],
          UserName: answer.data()["UserName"],
          userImage: answer.data()["UserImage"],
          content: answer.data()["Content"],
          role: answer.data()["Role"]);
      qa.answer = a;
      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(answer.data()["QuestionId"])
          .get()
          .then((value) {
        Question question = Question(
            questionId: value.id,
            patientId: value.data()!["PatientId"],
            patientName: value.data()!["PatientName"],
            patientImage: value.data()!["PatientImage"],
            content: value.data()!["Content"],
            answers: value.data()!["Answers"],
            date: value.data()!["Date"]);
        qa.question = question;
      });
      qaList.add(qa);
    }
  });
  return qaList;
}
