import 'package:api/api_call/res/location.dart';

import 'dart:convert';
import 'package:api/api_call/model/result_model.dart';
import 'package:http/http.dart' as http;

abstract class QuestionRepository {
  // Future<List<Questions>> getQuestions();
  Future<ApiResultModel> questions();
}

class QuestionRepositoryImpl implements QuestionRepository {
  @override
  Future<ApiResultModel> questions() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/tanmay8400/response/main/response.json'));
    var body = jsonDecode(response.body);
    print("Question response->" + body.toString());
    return ApiResultModel.fromJson(body);
  }

  // Future<List<Questions>> getQuestions() async {
  //   var response = await http.get(Uri.parse(AppStrings.questionsUrl));
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     print(data);
  //     List<Questions>? questions = ApiResultModel.fromJson(data).questions;
  //     return questions!;
  //   } else {
  //     throw Exception();
  //   }
  // }
}
