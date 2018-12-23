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

  factory Gender.fromValue(String value) {
    switch(value) {
      case "MALE":
        return MALE;
        break;
      case "FEMALE":
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

class Role extends Constant {
  static final Role STUDENT = new Role('Пользователь', 'STUDENT');
  static final Role TEACHER = new Role('Эксперт', 'TEACHER');

  Role(String title, value) : super(title, value);

  factory Role.fromTitle(String title) {
    switch(title) {
      case 'Пользователь':
        return STUDENT;
        break;
      case 'Эксперт':
        return TEACHER;
        break;
      default:
        return null;
    }
  }

  factory Role.fromValue(String value) {
    switch(value) {
      case 'STUDENT':
        return STUDENT;
        break;
      case 'TEACHER':
        return TEACHER;
        break;
      default:
        return null;
    }
  }
}

class Work extends Constant {
  static final Work HUMAN = new Work('Человек', 'HUMAN');
  static final Work TECHNICS = new Work('Техника', 'TECHNICS');
  static final Work ZNAK = new Work('Знак', 'ZNAK');
  static final Work ART = new Work('Творчество', 'ART');
  static final Work NATURE = new Work('Природа', 'NATURE');
  static final Work EXECUTOR = new Work('Исполнитель', 'EXECUTOR');
  static final Work CREATOR = new Work('Создатель', 'CREATOR');

  Work(String title, value) : super(title, value);

  factory Work.fromTitle(String title) {
    switch(title) {
      case 'HUMAN':
        return HUMAN;
        break;
      case 'TECHNICS':
        return TECHNICS;
        break;
      case 'ZNAK':
        return ZNAK;
        break;
      case 'ART':
        return ART;
        break;
      case 'NATURE':
        return NATURE;
        break;
      case 'EXECUTOR':
        return EXECUTOR;
        break;
      case 'CREATOR':
        return CREATOR;
        break;
      default:
        return null;
    }
  }
}
class Constant {
  final String title;
  var value;

  Constant(this.title, this.value);
}