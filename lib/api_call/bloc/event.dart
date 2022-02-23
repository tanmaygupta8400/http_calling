import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {}

class FetchQuestionEvent extends QuestionEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
