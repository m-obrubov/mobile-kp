class Profession {
  final String description;
  final String value;

  Profession(this.description, this.value);

  factory Profession.fromJson(Map<String, dynamic> json) {
    return new Profession(json['description'], json['value']);
  }

  static List<Profession> listFromJson(List<dynamic> json) {
    List<Profession> professions = new List();
    for(dynamic d in json) {
      professions.add(Profession.fromJson(d));
    }
    return professions;
  }
}