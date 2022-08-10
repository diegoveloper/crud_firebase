import 'dart:convert';

List<Person> personFromJson(String str) =>
    List<Person>.from(json.decode(str).map((x) => Person.fromJson(x)));

String personToJson(List<Person> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Person {
  Person({
    required this.name,
    required this.lastname,
    required this.gender,
    this.id,
  });

  final String name;
  final String lastname;
  final String gender;
  final String? id;

  Person copyWith({
    String? name,
    String? lastname,
    String? gender,
    String? id,
  }) =>
      Person(
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        gender: gender ?? this.gender,
        id: id ?? this.id,
      );

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["name"],
        lastname: json["lastname"],
        gender: json["gender"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "gender": gender,
      };
}
