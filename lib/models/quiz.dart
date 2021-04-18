class Quiz {
  String answer;
  String question;
  Quiz.fromMap(dynamic data) {
    answer = data['answer'];
    question = data['question'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['question'] = this.question;
    return data;
  }

  Quiz({this.answer, this.question});
}