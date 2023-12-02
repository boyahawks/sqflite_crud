part of "./student.dart";

class StudentModel {
  int id;
  String username;
  DateTime birthDate;
  int age;
  bool gender;
  String address;

  StudentModel({
    required this.id,
    required this.username,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.address,
  });

  factory StudentModel.fromMap(Map<dynamic, dynamic> json) => StudentModel(
      id: json["id"],
      username: json["username"],
      birthDate: DateTime.parse(json["birthdate"]),
      age: json["age"],
      gender: (json["gender"].toLowerCase() == 'true'),
      address: json["address"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "birthdate":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": "$gender",
        "address": address,
      };

  String toJson() => json.encode(toMap());
}
