import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// to set the root of app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    HttpService().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter - API Implementation"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
    );
  }

  FutureBuilder<List<Question>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<Question>>(
      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Question> posts = snapshot.data!;
          return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  ListView _buildPosts(BuildContext context, List<Question> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].TestUserId.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].QuestionTypeId.toString()),
          ),
        );
      },
    );
  }
}

class HttpService {
  final String postsURL =
      "https://raw.githubusercontent.com/tanmay8400/response/main/response.json";

  Future<List<Question>> getPosts() async {
    var res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var questions = body["questions"] as List;

      List<Question> posts =
          questions.map<Question>((item) => Question.fromJson(item)).toList();
      print(body);
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}

// List<Question> questionFromJson(String str) =>
//     List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));
// String questionToJson(List<Question> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        TestUserId: json["TestUserId"],
        StartedOn: json["StartedOn"],
        Part: json["Part"],
        PartSerialNumber: json["PartSerialNumber"],
        SerialNumber: json["SerialNumber"],
        NegativeMarks: json["NegativeMarks"],
        AllowedAttempts: json["AllowedAttempts"],
        IsCompleted: json["IsCompleted"],
        QuestionTypeId: json["QuestionTypeId"],
        IsAttempted: json["IsAttempted"],
        IsMarkedForReview: json["IsMarkedForReview"]);
  }

  Map<String, dynamic> toJson() => {
        "TestUserId": TestUserId,
        "SerialNumber": SerialNumber,
        "StartedOn": StartedOn,
        "Part": Part,
        "PartSerialNumber": PartSerialNumber,
        "NegativeMarks": NegativeMarks,
        "AllowedAttempts": AllowedAttempts,
        "IsCompleted": IsCompleted,
        "QuestionTypeId": QuestionTypeId,
        "IsAttempted": IsAttempted,
        "IsMarkedForReview": IsMarkedForReview,
      };
}
