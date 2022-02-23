import 'dart:convert';

class QuestionsModel {
  Object? TestUserId;
  Object? StartedOn;
  Object? Part;
  Object? PartSerialNumber;
  Object? SerialNumber;
  Object? NegativeMarks;
  Object? AllowedAttempts;
  Object? IsCompleted;
  Object? QuestionTypeId;
  Object? IsAttempted;
  Object? IsMarkedForReview;

  QuestionsModel({
    this.AllowedAttempts,
    this.IsAttempted,
    this.IsCompleted,
    this.IsMarkedForReview,
    this.NegativeMarks,
    this.Part,
    this.PartSerialNumber,
    this.QuestionTypeId,
    this.SerialNumber,
    this.StartedOn,
    this.TestUserId,
  });

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    TestUserId = json['TestUserId'];
    StartedOn = json['StartedOn'];
    Part = json['Part'];
    PartSerialNumber = json['PartSerialNumber'];
    SerialNumber = json['SerialNumber'];
    NegativeMarks = json['NegativeMarks'];
    AllowedAttempts = json['AllowedAttempts'];
    IsCompleted = json['IsCompleted'];
    QuestionTypeId = json['QuestionTypeId'];
    IsAttempted = json['IsAttempted'];
    IsMarkedForReview = json['IsMarkedForReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['TestUserId'] = this.TestUserId;
    data['SerialNumber'] = this.SerialNumber;
    data['StartedOn'] = this.StartedOn;
    data['Part'] = this.Part;
    data['PartSerialNumber'] = this.PartSerialNumber;
    data['NegativeMarks'] = this.NegativeMarks;
    data['AllowedAttempts'] = this.AllowedAttempts;
    data['IsCompleted'] = this.IsCompleted;
    data['IsMarkedForReview'] = this.IsMarkedForReview;

    return data;
  }
}

ApiResultModel effortAnalysisResultModelFromJson(String questions) =>
    ApiResultModel.fromJson(json.decode(questions));

class ApiResultModel {
  ApiResultModel({this.questions});
  // String? status;

  List<QuestionsModel>? questions;

  factory ApiResultModel.fromJson(Map<String, dynamic> questionsJson) =>
      ApiResultModel(
          questions: List<QuestionsModel>.from(questionsJson["questions"]
              .map((x) => QuestionsModel.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
      };
  // {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //
  //   data['questions'] = this.questions;
  //   if (this.questions != null) {
  //     data['articles'] = this.questions!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
