import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_trivia_api/models/api_response.dart';
import 'package:quiz_app_trivia_api/util/constants.dart';

class CorrectAnswersScreen extends StatelessWidget {
  final ApiResponse apiResponse;

  const CorrectAnswersScreen({Key? key, required this.apiResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Correct Answers',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: apiResponse.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Results result = apiResponse.results[index];

                  var options = result.incorrectAnswers;
                  options.add(result.correctAnswer);
                  //options.shuffle();

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Question # ${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white70),
                          child: Text(
                            '${result.question}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: options[0] == result.correctAnswer
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () {},
                          child: Text('${options[0]}'),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: options[1] == result.correctAnswer
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () {},
                          child: Text('${options[1]}'),
                        ),


                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: options[2] == result.correctAnswer
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () {},
                          child: Text('${options[2]}'),
                        ),


                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: options[3] == result.correctAnswer
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () {},
                          child: Text('${options[3]}'),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
