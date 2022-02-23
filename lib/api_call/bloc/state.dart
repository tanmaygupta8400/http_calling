import 'package:api/api_call/model/result_model.dart';
import 'package:equatable/equatable.dart';

abstract class QuestionState extends Equatable {}

class QuestionInitialState extends QuestionState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class QuestionLoadingState extends QuestionState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class QuestionLoadedState extends QuestionState {
  ApiResultModel questions;

  QuestionLoadedState({required this.questions});

  @override
  // TODO: implement props
  List<Object> get props => [questions];
}

class QuestionErrorState extends QuestionState {
  String? message;

  QuestionErrorState({this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}
