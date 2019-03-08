import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/my_strings.dart';
import 'package:fourybyoffline/dashboard/answer_manager.dart';
import 'package:meta/meta.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class Question {
  final String q;
  final String type;
  final List<String> options;
  final bool hasTextField;
  final int skipIndex;
  final List<int> skipPositions;
  final List<int> textIndexes;

  const Question(
      {@required this.q,
      @required this.hasTextField,
      this.type,
      this.options,
      this.skipIndex,
      this.textIndexes,
      this.skipPositions});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Question && runtimeType == other.runtimeType && q == other.q;

  @override
  int get hashCode => q.hashCode;
}

class QuestionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<String> onInputtedAnswerChange;
  final ValueChanged<String> onSelectedAnswerChange;

  QuestionWidget(
      {@required this.question,
      @required this.onInputtedAnswerChange,
      @required this.onSelectedAnswerChange});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String selectedItem;
  final answerManager = new AnswerManager();
  TextEditingController controller;
  SharedPreferences prefs;
  int currentUser;

  @override
  void initState() {
    answerManager.fieldPH();
    selectedItem =
        answerManager.questionsHolder[questions.indexOf(widget.question)];
    controller = new TextEditingController(
        text: answerManager
            .textFormTextHolder[questions.indexOf(widget.question)]);
            initCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: const BoxDecoration(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(50.0)),
                color: Colors.black12),
            child: new Text(
              '${questions.indexOf(widget.question) + 1}/${questions.length}',
              style: const TextStyle(fontSize: 18.0),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 20.0),
          ),
          const SizedBox(height: 20.0),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: new Text(
              '${widget.question.q}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
          widget.question.options != null
              ? new Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 30.0),
                  child: new DropdownButtonHideUnderline(
                      child: new InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      hintText: 'Tap here to choose',
                    ),
                    isEmpty: selectedItem == null,
                    child: DropdownButton<String>(
                      value: selectedItem,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          selectedItem = newValue;
                        });
                        widget.onSelectedAnswerChange(selectedItem);
                        answerManager.questionsHolder[
                            questions.indexOf(widget.question)] = selectedItem;
                      },
                      items: widget.question.options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            maxLines: 2,
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontSize: 15),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
                )
              : new Container(), 
          widget.question.options == null ||
                  widget.question.hasTextField &&
                      selectedItem != null &&
                      widget.question.textIndexes != null &&
                      widget.question.textIndexes.contains(
                          widget.question.options.indexOf(selectedItem))
              ? new Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: new TextField(
                    enabled: widget.question.type == 'std' ? false : true,
                    keyboardType: widget.question.type == 'text'
                        ? TextInputType.text
                        : widget.question.type == 'number'
                            ? TextInputType.number
                            : widget.question.type == 'phone'
                                ? TextInputType.phone
                                : widget.question.type == 'email'
                                    ? TextInputType.emailAddress
                                    : TextInputType.text,
                    decoration: InputDecoration(
                      labelText: widget.question.type == 'std' ? currentUser.toString() : 'Type here',
                    ),
                    controller: controller,
                    onChanged: (value) {
                      widget.onInputtedAnswerChange(value);
                      answerManager.textFormTextHolder[
                          questions.indexOf(widget.question)] = value;
                    },
                  ),
                )
              : new SizedBox()
        ],
      ),
    );
  }
}

var questions = [
  Question(
    q: 'What is your First name?',
    hasTextField: true,
    type: 'text',
  ),
  Question(
    q: 'What is your Last name?',
    hasTextField: true,
    type: 'text',
  ),
  Question(
    q: 'What is your Email?',
    hasTextField: true,
    type: 'email',
  ),
  Question(
    q: 'What is your Phone?',
    hasTextField: true,
    type: 'phone',
  ),
  Question(
    q: 'Your Study ID is',
    hasTextField: true,
    type: 'std',
  ),
  Question(
    q: 'What is your gender?',
    options: ['Male', 'Female', 'Transgender', Strings.notListedSpecify],
    hasTextField: true,
    textIndexes: [3],
  ),
  Question(
    q: 'What is your age?',
    hasTextField: true,
    type: 'number',
  ),
  Question(
      q: 'What is your religion?',
      options: [
        'Christianity',
        'Islam',
        'Traditional',
        Strings.notListedSpecify
      ],
      hasTextField: true,
      textIndexes: [3]),
  Question(
    q: 'What is your ethnicity?',
    options: ['Hausa', 'Igbo', 'Yoruba', Strings.notListedSpecify],
    hasTextField: true,
    textIndexes: [3],
  ),
  Question(
      q: 'What is your highest education level?',
      options: [
        'No education',
        'Primary education ',
        'Secondary education',
        'Bachelors',
        'Masters',
        'PhD and other professional degrees',
        Strings.notListedSpecify,
      ],
      hasTextField: true,
      textIndexes: [6]),
  Question(
      q: 'What is your employment status?',
      options: [
        'Unemployed',
        'Employed, please specify type of job',
        'Student',
        Strings.notListedSpecify,
      ],
      hasTextField: true,
      textIndexes: [1, 3]),
  Question(
      q: 'What is your relationship status?',
      options: [
        'Single',
        'Married',
        'Widow',
        'Separated',
        'Divorced',
        'In a relationship and living with partner',
        'In a relationship but not living with partner',
        Strings.notListedSpecify,
      ],
      hasTextField: true,
      textIndexes: [4]),
  Question(
    q: 'Have you ever had sex (including oral sex) in your lifetime?',
    options: ['Yes', 'No'],
    hasTextField: false,
    skipIndex: 3,
    skipPositions: [1],
  ),
  Question(
    q: 'At what age did you first have sex?',
    hasTextField: true,
    type: 'text',
  ),
  Question(
    q: 'In the last 6 months, have you ever had sex without condom?',
    options: ['Yes', 'No'],
    hasTextField: false,
  ),
  Question(
      q: 'Have you ever tested for HIV?',
      options: ['Yes', 'No', 'I don’t know'],
      hasTextField: false,
      skipPositions: [1, 2],
      skipIndex: 5),
  Question(
    q: 'How many times have you ever tested for HIV?',
    hasTextField: true,
    type: 'number',
  ),
  Question(
    q: 'How long ago was your most recent HIV test?',
    hasTextField: true,
    type: 'text',
  ),
  Question(
      q: 'What was your most recent HIV test result?',
      options: [
        'Negative',
        'Positive',
        'Didn’t get the result',
      ],
      hasTextField: false),
  Question(
      q: 'Where did you get your most result HIV test?',
      options: [
        'Hospital',
        'Home',
        'Health seminar',
        'Not applicable',
        Strings.notListedSpecify,
      ],
      hasTextField: true,
      textIndexes: [4]),
  Question(
      q: 'If never tested, please indicate reasons for not testing (please check all that apply)?',
      options: [
        ' I think I have a low chance of getting HIV',
        'It takes too much time/ it is inconvenient',
        'It is expensive',
        'I don’t know where to get tested',
        'I am afraid of knowing that I may have HIV'
            'Testing centers are far from my house'
            'I am afraid of what people will say',
        Strings.notListedSpecify
      ],
      hasTextField: true,
      textIndexes: [5]),
  Question(
      q: 'Have you ever used HIV self-testing in the past?',
      options: ['Yes', 'No', 'I don’t know what it is'],
      hasTextField: false),
];
