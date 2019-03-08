import 'package:fourybyoffline/dashboard/questions/question.dart';

class AnswerManager {
  static final AnswerManager _singleton = new AnswerManager._internal();

  List questionsHolder = [];
  List textFormTextHolder = [];

  fieldPH() {
    for (int i = 0; i < questions.length; i++) {
      questionsHolder.add(null);
      textFormTextHolder.add(null);
    }
  }

  factory AnswerManager() {
    return _singleton;
  }

  AnswerManager._internal();
}
