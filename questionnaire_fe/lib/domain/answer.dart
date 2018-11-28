class Answer {
   final int id;
   final String value;

   Answer(this.id, this.value); //Значение

   factory Answer.fromJson(Map<String, dynamic> json) {
     return new Answer(json['id'], json['value']);
   }

   static List<Answer> listFromJson(List<dynamic> json) {
     List<Answer> answers = new List();
     for(dynamic d in json) {
       answers.add(Answer.fromJson(d));
     }
     return answers;
   }
}