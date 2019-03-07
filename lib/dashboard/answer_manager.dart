import 'package:fourybyoffline/dashboard/questions/question.dart';
class AnswerManager {
  static final AnswerManager _singleton = new AnswerManager._internal();

  var questionsHolder = new List(questions.length);
  var textFormTextHolder = new List(questions.length);

  factory AnswerManager() {
    return _singleton;
  }

  AnswerManager._internal();
}
