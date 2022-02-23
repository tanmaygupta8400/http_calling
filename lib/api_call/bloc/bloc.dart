import 'package:api/api_call/bloc/event.dart';
import 'package:api/api_call/bloc/state.dart';
import 'package:api/api_call/model/result_model.dart';
import 'package:api/api_call/repository/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionRepository repository;

  @override
  // TODO: implement initialState
  // QuestionState get initialState => QuestionInitialState();
  //
  // QuestionBloc({required this.repository}) : super(QuestionInitialState());

  QuestionState get initialState => QuestionInitialState();

  QuestionBloc({required this.repository}) : super(QuestionInitialState()) {
    on<QuestionEvent>((event, emit) async {
      emit(QuestionLoadingState());
      try {
        ApiResultModel questionModel = await repository.questions();
        if (questionModel.questions != null) {
          emit(QuestionLoadedState(questions: questionModel));
        } else {
          emit(QuestionErrorState(message: 'Error'));
        }
      } catch (e) {
        emit(QuestionErrorState(message: 'Error'));
      }
    });

    // @override
    // Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    //   if (event is FetchQuestionEvent) {
    //     yield QuestionLoadingState();
    //     // try {
    //     List<Questions> questions = await repository.getQuestions();
    //     yield QuestionLoadedState(questions: questions);
    //     // } catch (e) {
    //     //   yield QuestionErrorState(message: e.toString());
    //     // }
    //   }
    // }
  }
}
