import 'package:flutter/material.dart';

enum Department { finance, law, it, medical }
enum Gender { male, female }

class Student {
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.grade,
    required this.gender,
  });

  Student copyWith({
    String? firstName,
    String? lastName,
    String? departmentId,
    int? grade,
    Gender? gender,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      departmentId: departmentId ?? this.departmentId,
      grade: grade ?? this.grade,
      gender: gender ?? this.gender,
    );
  }
}

// Глобальна змінна з іконками для кожного департаменту
final Map<String, IconData> departmentIcons = {
  '1': Icons.attach_money,
  '2': Icons.gavel,
  '3': Icons.computer,
  '4': Icons.local_hospital,
};
