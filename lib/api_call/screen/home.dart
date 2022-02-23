import 'package:api/api_call/bloc/bloc.dart';
import 'package:api/api_call/bloc/event.dart';
import 'package:api/api_call/bloc/state.dart';
import 'package:api/api_call/model/result_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuestionsModel> questions = [];
  QuestionBloc? questionBloc;
  @override
  void initState() {
    questionBloc = BlocProvider.of<QuestionBloc>(context);
    questionBloc!.add(FetchQuestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Api Calling"),
              ),
              body: BlocConsumer<QuestionBloc, QuestionState>(
                  listener: (BuildContext context, QuestionState state) {
                if (state is QuestionInitialState) {
                  Container(
                    child: Text(' In Initial state'),
                  );
                } else if (state is QuestionLoadingState) {
                  Container(
                    child: Text(
                      'data is loading',
                    ),
                  );
                } else if (state is QuestionLoadedState) {
                  if (state.questions != null)
                    // buildQuestionList(state.questions);
                    setState(() {
                      questions = state.questions.questions!;
                      Center(
                          child: Text(
                        'inside the loaded state',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ));
                      print('loaded state');
                    });
                } else if (state is QuestionErrorState) {
                  Text("Network Issue");
                }
              }, builder: (BuildContext context, QuestionState state) {
                return ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 110,
                      child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'TestUserId = ' +
                                        questions[index].TestUserId.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text('StaredOn Date: ' +
                                      questions[index].StartedOn.toString())
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Part: ' +
                                      questions[index].Part.toString())
                                ],
                              ),
                              Column(
                                children: [
                                  Text('PartSerialNumber: ' +
                                      questions[index]
                                          .PartSerialNumber
                                          .toString())
                                ],
                              ),
                              Column(
                                children: [
                                  Text('SerialNumber: ' +
                                      questions[index].SerialNumber.toString())
                                ],
                              ),
                            ],
                          )
                          // ListTile(
                          //   title: Text(
                          //     questions[index].TestUserId.toString(),
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   ),
                          //   subtitle: Text(questions[index].StartedOn.toString()),
                          // ),
                          ),
                    );
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 16),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  // Widget buildQuestionList(List<Questions>? questions) {
  //   return Text(questions![0].SerialNumber.toString());
  // }
}
