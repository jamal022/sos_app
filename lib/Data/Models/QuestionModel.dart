import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/AnswerModel.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import '../../Presentation/Widgets/loading_widget.dart';

class Question {
  var questionId;
  var patientId;
  var patientImage;
  var patientName;
  var content;
  var answers;
  var date;

  Question({
    this.questionId,
    required this.patientId,
    this.patientName,
    this.patientImage,
    required this.content,
    required this.answers,
    required this.date,
  });
}

AddQuestion(Question question, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Questions").add({
    "PatientId": question.patientId,
    "Date": question.date,
    "Content": question.content,
    "Answers": question.answers,
  });
  Navigator.pop(context);
  return "Added";
}

GetAllQuestions() async {
  List<Question> questions = [];
  await FirebaseFirestore.instance
      .collection("Questions")
      .orderBy("Answers", descending: true)
      .get()
      .then((value) async {
    for (var quest in value.docs) {
      var name, image;
      await FirebaseFirestore.instance
          .collection("Patients")
          .doc(quest.data()["PatientId"])
          .get()
          .then((value) {
        name = value.data()!["FullName"];
        image = value.data()!["Image"];
      });
      Question q = Question(
        questionId: quest.id,
        patientId: quest.data()["PatientId"],
        patientName: name,
        patientImage: image,
        answers: quest.data()["Answers"],
        content: quest.data()["Content"],
        date: quest.data()["Date"],
      );
      questions.add(q);
    }
  });
  return questions;
}

AddAnswerToQuestion(questionId) async {
  await FirebaseFirestore.instance
      .collection("Questions")
      .doc(questionId)
      .get()
      .then((value) async {
    var answer;
    if (value.data()!["Answers"] == 0) {
      answer = 1;
    } else {
      answer = value.data()!["Answers"] + 1;
    }
    await FirebaseFirestore.instance
        .collection("Questions")
        .doc(value.id)
        .update({"Answers": answer});
  });
}

DeleteAnswerFromQuestion(questionId) async {
  await FirebaseFirestore.instance
      .collection("Questions")
      .doc(questionId)
      .get()
      .then((value) async {
    var answer = value.data()!["Answers"] - 1;

    await FirebaseFirestore.instance
        .collection("Questions")
        .doc(value.id)
        .update({"Answers": answer});
  });
}

GetAnswersCount(questionId) async {
  var answers = 0;
  await FirebaseFirestore.instance
      .collection("Questions")
      .doc(questionId)
      .get()
      .then((value) {
    answers = value.data()!["Answers"];
  });
  return answers;
}

GetPatientQuestions(patientId) async {
  List<Question> questions = [];
  var name, image;
  await FirebaseFirestore.instance
      .collection("Patients")
      .doc(patientId)
      .get()
      .then((value) {
    name = value.data()!["FullName"];
    image = value.data()!["Image"];
  });
  await FirebaseFirestore.instance
      .collection("Questions")
      .where("PatientId", isEqualTo: patientId)
      .get()
      .then((value) {
    for (var quest in value.docs) {
      Question q = Question(
        questionId: quest.id,
        patientId: quest.data()["PatientId"],
        patientImage: image,
        patientName: name,
        answers: quest.data()["Answers"],
        content: quest.data()["Content"],
        date: quest.data()["Date"],
      );
      questions.add(q);
    }
  });
  return questions;
}

DeleteQuestion({questionId, content, userId, context, String? role}) async {
  var userToken;
  await FirebaseFirestore.instance
      .collection("Questions")
      .doc(questionId)
      .delete()
      .then((value) async {
    await DeleteQuestionAnswers(questionId);
  }).then((value) async {
    if (role == "admin") {
      await FirebaseFirestore.instance
          .collection("Patients")
          .doc(userId)
          .get()
          .then((value) => userToken = value.data()!["Token"]);

      if (content.length > 16) {
        content = content.substring(0, 15) + "..";
      }
      SendNotifyToUser(
          'The Admin deleted your question "${content}"', userToken!, userId!);
    }
  });
  Navigator.pop(context);
  return "deleted";
}
