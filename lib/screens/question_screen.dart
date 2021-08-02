import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app_trivia_api/models/api_response.dart';
import 'package:quiz_app_trivia_api/screens/result_screen.dart';

import 'package:quiz_app_trivia_api/util/constants.dart';

class QuestionScreen extends StatefulWidget {
  final ApiResponse apiResponse;

  const QuestionScreen({Key? key, required this.apiResponse}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentIndex = 0;
  late String question;
  late String correctAnswer;
  late List<String> options;
  int totalCorrect = 0;
  int remainingSeconds = 30;
  Timer? t;


  _displayQuestion() {
    var result = widget.apiResponse.results[currentIndex];
    question = result.question;
    correctAnswer = result.correctAnswer;
    options = result.incorrectAnswers;
    options.add(result.correctAnswer);
    options.shuffle();

    _startCountDown();
    setState(() {});
  }

  _startCountDown(){

    if( t != null ){
      t!.cancel();
    }

    int i = 0;
    t = Timer.periodic(Duration(seconds: 1), (timer) { setState(() {

      i++;
      remainingSeconds = 30 - i;

      if( remainingSeconds == 0){
        timer.cancel();
        _goToNextQuestion();
      }

    });});
  }


  _checkAnswer(int index) {
    if (correctAnswer == options[index]) {
      Fluttertoast.showToast(
          msg: 'Correct',
          backgroundColor: Colors.green,
          gravity: ToastGravity.CENTER);
      totalCorrect++;
    } else {
      Fluttertoast.showToast(
          msg: 'Wrong', backgroundColor: Colors.red, gravity: ToastGravity.CENTER);
    }

    _goToNextQuestion();
  }

  _goToNextQuestion() {
    if (currentIndex == 9) {
      Fluttertoast.showToast(
          msg: 'No more questions',
          backgroundColor: Colors.blue,
          gravity: ToastGravity.TOP);

      if( t != null){
        t!.cancel();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){

        return ResultScreen(correct: totalCorrect, apiResponse: widget.apiResponse);
      }));
    } else {
      currentIndex++;
      _displayQuestion();
    }
  }

  @override
  void initState() {
    _displayQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
        backgroundColor: bgColor,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/icon.png'),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Text(
                      '${currentIndex + 1} / 10',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$remainingSeconds s',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  question,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: (){_checkAnswer(0);},
                  child: Text(
                    options[0],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: (){_checkAnswer(1);},
                  child: Text(
                    options[1],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: (){_checkAnswer(2);},
                  child: Text(
                    options[2],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: (){_checkAnswer(3);},
                  child: Text(
                    options[3],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
