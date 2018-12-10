class Gender extends Constant {
  static final Gender MALE = new Gender('Мужской', 'MALE');
  static final Gender FEMALE = new Gender('Женский', 'FEMALE');

  Gender(String title, value) : super(title, value);

  factory Gender.fromTitle(String title) {
    switch(title) {
      case 'Мужской':
        return MALE;
        break;
      case 'Женский':
        return FEMALE;
        break;
      default:
        return null;
    }
  }

  bool equals(Gender other) {
    return other.value == value && other.title == title;
  }
}

class Constant {
  final String title;
  var value;

  Constant(this.title, this.value);
}