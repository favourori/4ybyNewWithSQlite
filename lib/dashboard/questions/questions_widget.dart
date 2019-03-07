import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/common/my_utils.dart';
import 'package:fourybyoffline/dashboard/answer_manager.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';
import 'package:fourybyoffline/dashboard/questions/finish_test_wiget.dart';
import 'package:fourybyoffline/dashboard/questions/question.dart';
import 'package:fourybyoffline/data/response.dart';

class QuestionsWidget extends StatefulWidget {
  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends BaseState<QuestionsWidget>
    with SingleTickerProviderStateMixin {
  final AnswerManager answerManager = new AnswerManager();
  TabController _tabController;
  var _currentIndex = 0;
  String selectedAnswer;
  String inputtedAnswer;
  SharedPreferences prefs;
  int currentUser;

  _QuestionsWidgetState() : super('QUESTIONS');

  @override
  void initState() {
    super.initState();
    initCurrentUser();
    _tabController = new TabController(
        vsync: this, length: questions.length, initialIndex: _currentIndex);
    _tabController.addListener(_indexChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initCurrentUser() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e.message);
    } finally {
      setState(() {
        currentUser = prefs.getInt('currentUser');
      });
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return new Container(
      color: Colors.grey[50],
      child: new Column(
        children: <Widget>[
          new Expanded(
              child: new Card(
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              child: new TabBarView(
                physics: new NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: questions
                    .map((question) => new QuestionWidget(
                          question: question,
                          onInputtedAnswerChange: (value) =>
                              setState(() => inputtedAnswer = value),
                          onSelectedAnswerChange: (value) =>
                              setState(() => selectedAnswer = value),
                        ))
                    .toList(),
              ),
            ),
          )),
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _currentIndex > 0
                    ? new RaisedButton(
                        onPressed: () {
                          _tabController.animateTo(_currentIndex - 1);
                        },
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        textColor: Colors.white,
                        child: const Text('Previous'),
                        color: MyColors.orange,
                        shape: const RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0))),
                      )
                    : const SizedBox(),
                new RaisedButton(
                  onPressed: answered() 
                      ? () {
                          _currentIndex == (questions.length - 1)
                              ? Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (_) => new FinishTestWidget()))
                              : goToNextQuestion(questions[_currentIndex]);
                        }
                      : null,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  textColor: Colors.white,
                  child: new Text(_currentIndex == (questions.length - 1)
                      ? 'Done'
                      : 'Next'),
                  color: MyColors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50.0))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _indexChange() {
    setState(() {
      _currentIndex = _tabController.index;
      this.selectedAnswer = answerManager.questionsHolder[_currentIndex];
      this.inputtedAnswer = answerManager.textFormTextHolder[_currentIndex];
    });
  }

  goToNextQuestion(Question question) {
    String inputtedAnswer = this.inputtedAnswer;
    String selectedAnswer = this.selectedAnswer;

    this.inputtedAnswer = null;
    this.selectedAnswer = null;

    var skipIndex = question.skipIndex != null &&
            question.skipPositions
                .contains(question.options.indexOf(selectedAnswer))
        ? question.skipIndex
        : 1;

    _tabController.animateTo(_currentIndex + skipIndex);
    if(question.type != 'std') {
      new UserResponse(
            question: question.q,
            answer: question.hasTextField && inputtedAnswer != null
                ? inputtedAnswer
                : selectedAnswer)
        .saveResponse(
            studyID: currentUser,
            type: 'Questions');
    }
  }

  bool answered() {
    var question = questions[_currentIndex];
    if (question.hasTextField) {
      if(question.type == 'std') {
        return true;
      } else if (question.options == null) {
        return MyUtils.isValid(inputtedAnswer);
      } else {
        var indexOfSelectedOption = question.options.indexOf(selectedAnswer);
        if (question.textIndexes.contains(indexOfSelectedOption)) {
          return MyUtils.isValid(inputtedAnswer);
        } else {
          return MyUtils.isValid(selectedAnswer);
        }
      }
    } else {
      return MyUtils.isValid(selectedAnswer);
    }
  }
}
