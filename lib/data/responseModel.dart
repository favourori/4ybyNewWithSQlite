class Response {
  int studyID;
  String question;
  String answer;
 
  Response(this.question, this.answer);
 
  Response.map(dynamic obj) {
    this.studyID = obj['studyID'];
    this.question = obj['question'];
    this.answer = obj['answer'];
  }
 
  int get id => studyID;
  String get title => question;
  String get description => answer;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (studyID != null) {
      map['studyID'] = studyID;
    }
    map['question'] = question;
    map['answer'] = answer;
 
    return map;
  }
 
  Response.fromMap(Map<String, dynamic> map) {
    this.studyID = map['studyID'];
    this.question = map['question'];
    this.answer = map['answer'];
  }
}