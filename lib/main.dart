import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'api_call/bloc/bloc.dart';
import 'api_call/bloc/state.dart';
import 'api_call/repository/repo.dart';
import 'api_call/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api',
      home: BlocProvider(
        create: (BuildContext context) =>
            QuestionBloc(repository: QuestionRepositoryImpl()),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => HomePage(),
          },
        ),
      ),
    );
  }
}
