import 'package:flutter/material.dart';
import 'package:quiz_app_trivia_api/models/api_response.dart';
import 'package:quiz_app_trivia_api/screens/correct_answers_screen.dart';
import 'package:quiz_app_trivia_api/util/constants.dart';

class ResultScreen extends StatelessWidget {
  final int correct;
  final ApiResponse apiResponse;

  const ResultScreen(
      {Key? key, required this.correct, required this.apiResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
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
            Text('$correct / 10',
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
                  Navigator.of(context).pop();
                },
                child: Text(
                  'HOME',
                  style: TextStyle(
                    fontSize: 25,
                  ),
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CorrectAnswersScreen(apiResponse: apiResponse);
                  }));
                },
                child: Text(
                  'VIEW CORRECT ANSWERS',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
