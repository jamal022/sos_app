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
    required this.patientName,
    required this.patientImage,
    required this.content,
    required this.answers,
    required this.date,
  });
}

AddQuestion(Question question, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Questions").add({
    "PatientId": question.patientId,
    "PatientName": question.patientName,
    "PatientImage": question.patientImage,
    "Date": question.date,
    "Content": question.content,
    "Answers": question.answers,
  }).then((value) {
    SendNotifyToTopic('New Question was added "${question.content}"');
  });
  Navigator.pop(context);
  return "Added";
}

GetAllQuestions() async {
  List<Question> questions = [];
  await FirebaseFirestore.instance.collection("Questions").get().then((value) {
    for (var quest in value.docs) {
      Question q = Question(
        questionId: quest.id,
        patientId: quest.data()["PatientId"],
        patientName: quest.data()["PatientName"],
        patientImage: quest.data()["PatientImage"],
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
  await FirebaseFirestore.instance
      .collection("Questions")
      .where("PatientId", isEqualTo: patientId)
      .get()
      .then((value) {
    for (var quest in value.docs) {
      Question q = Question(
        questionId: quest.id,
        patientId: quest.data()["PatientId"],
        patientName: quest.data()["PatientName"],
        patientImage: quest.data()["PatientImage"],
        answers: quest.data()["Answers"],
        content: quest.data()["Content"],
        date: quest.data()["Date"],
      );
      questions.add(q);
    }
  });
  return questions;
}

DeleteQuestion(questionId, context) async {
  await FirebaseFirestore.instance
      .collection("Questions")
      .doc(questionId)
      .delete()
      .then((value) async {
    await DeleteQuestionAnswers(questionId);
  }).then((value) => Navigator.pop(context));
  return "deleted";
}
