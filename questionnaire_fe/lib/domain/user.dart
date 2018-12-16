import 'package:questionnaire_fe/domain/constants.dart';

class User {
  int id;
  String firstName;
  String lastName;
  int age;
  String city;
  Gender gender;
  String email;
  DateTime createdAt;

  String password;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.city,
    this.gender,
    this.email,
    this.createdAt,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      age: json["age"],
      city: json["city"],
      gender: Gender.fromValue(json["gender"]),
      email: json["email"],
      createdAt: DateTime.parse(json["created_at"])
    );
  }

  Map<String, dynamic> toJsonRegister() =>
      {
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "city": city,
        "gender": gender.value,
        "email": email,
        "password": password
      };

  Map<String, dynamic> compareFieldsAndGetJson(User updatedUser) {
    Map<String, dynamic> changedFields = new Map();

    if(updatedUser.firstName != firstName) {
      changedFields.putIfAbsent("first_name", () => updatedUser.firstName);
    }
    if(updatedUser.lastName != lastName) {
      changedFields.putIfAbsent("last_name", () => updatedUser.lastName);
    }
    if(updatedUser.age != age) {
      changedFields.putIfAbsent("age", () => updatedUser.age);
    }
    if(updatedUser.city != city) {
      changedFields.putIfAbsent("city", () => updatedUser.city);
    }
    if(!updatedUser.gender.equals(gender)) {
      changedFields.putIfAbsent("gender", () => updatedUser.gender);
    }

    return changedFields;
  }
}