import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app_trivia_api/models/api_response.dart';
import 'package:quiz_app_trivia_api/screens/question_screen.dart';
import 'package:quiz_app_trivia_api/util/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamController streamController;
  late Stream stream;

  getQuestions() async {
    streamController.add('loading');

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      var apiResponse = ApiResponse.fromJson(jsonResponse);

      if (apiResponse.results.length > 0) {
        streamController.add('done');

        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return QuestionScreen(apiResponse: apiResponse);
        }));
      } else {
        streamController.add('wrong');
      }
    } else {
      streamController.add('wrong');
    }
  }

  @override
  void initState() {
    streamController = StreamController();
    stream = streamController.stream;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ClipOval(
                child: Image(
                  image: AssetImage('assets/images/icon.png'),
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Quiz',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 45,
                  )),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                  onPressed: () {
                    getQuestions();
                  },
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )),
              SizedBox(
                height: 80,
              ),
              StreamBuilder(
                  stream: stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 'loading') {
                        return CircularProgressIndicator(
                          value: 2,
                        );
                      } else if (snapshot.data == 'wrong') {
                        return Text('Something went wrong, try again');
                      } else {
                        return SizedBox.shrink();
                      }
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
