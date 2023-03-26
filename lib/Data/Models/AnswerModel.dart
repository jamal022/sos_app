import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import 'package:sos_app/Data/Models/QuestionModel.dart';

import '../../Presentation/Widgets/loading_widget.dart';

class Answer {
  var answerId;
  var questionId;
  var userId;
  var userImage;
  var UserName;
  var content;
  var role;

  Answer({
    this.answerId,
    required this.questionId,
    required this.userId,
    required this.UserName,
    required this.userImage,
    required this.content,
    required this.role,
  });
}

AddAnswer(Answer answer, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Answers").add({
    "QuestionId": answer.questionId,
    "UserId": answer.userId,
    "UserName": answer.UserName,
    "UserImage": answer.userImage,
    "Content": answer.content,
    "Role": answer.role,
  }).then((value) async {
    await AddAnswerToQuestion(answer.questionId);
  }).then((value) async {
    var userToken;
    var userId;
    var questionContent;
    if (answer.role == "Patient") {
      await FirebaseFirestore.instance
          .collection("Patients")
          .doc(answer.userId)
          .get()
          .then((value) => userToken = value.data()!["Token"]);
    } else if (answer.role == "Doctor") {
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(answer.userId)
          .get()
          .then((value) => userToken = value.data()!["Token"]);
    }
    await FirebaseFirestore.instance
        .collection("Questions")
        .doc(answer.questionId)
        .get()
        .then(
      (value) {
        userId = value.data()!["PatientId"];
        questionContent = value.data()!["Content"];
      },
    );
    if (questionContent.length > 16) {
      questionContent = questionContent.substring(0, 15) + "..";
    }
    SendNotifyToUser('Someone answered your question "${questionContent}"',
        userToken, userId);
  });
  Navigator.pop(context);
  return "Added";
}

GetQuestionAnswers(questionId) async {
  List<Answer> answers = [];
  await FirebaseFirestore.instance
      .collection("Answers")
      .where("QuestionId", isEqualTo: questionId)
      .get()
      .then((value) {
    for (var an in value.docs) {
      Answer a = Answer(
        answerId: an.id,
        questionId: an.data()["QuestionId"],
        userId: an.data()["UserId"],
        UserName: an.data()["UserName"],
        userImage: an.data()["UserImage"],
        content: an.data()["Content"],
        role: an.data()["Role"],
      );
      answers.add(a);
    }
  });
  return answers;
}

DeleteQuestionAnswers(questionId) async {
  await FirebaseFirestore.instance
      .collection("Answers")
      .where("QuestionId", isEqualTo: questionId)
      .get()
      .then((value) async {
    for (var answer in value.docs) {
      await FirebaseFirestore.instance
          .collection("Answers")
          .doc(answer.id)
          .delete();
    }
  });
}

DeleteAnswer(
    {questionId,
    answerId,
    content,
    userId,
    userRole,
    context,
    String? role}) async {
  var userToken;
  await FirebaseFirestore.instance
      .collection("Answers")
      .doc(answerId)
      .delete()
      .then((value) async {
    await DeleteAnswerFromQuestion(questionId);
  }).then((value) async {
    if (role == "admin") {
      if (userRole == "Patient") {
        await FirebaseFirestore.instance
            .collection("Patients")
            .doc(userId)
            .get()
            .then((value) => userToken = value.data()!["Token"]);
      } else if (userRole == "Doctor") {
        await FirebaseFirestore.instance
            .collection("Doctors")
            .doc(userId)
            .get()
            .then((value) => userToken = value.data()!["Token"]);
      }
      if (content.length > 16) {
        content = content.substring(0, 15) + "..";
      }
      SendNotifyToUser(
          'The Admin deleted your answer "${content}"', userToken!, userId!);
    }
  });
  Navigator.pop(context);
  return "deleted";
}
