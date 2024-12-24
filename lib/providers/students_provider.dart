import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(this.ref, super.state);

  final Ref ref;
  //final String _baseUrl = 'https://students-1b24d-default-rtdb.firebasedatabase.com';
  final String _baseUrl = 'https://students-1b24d-default-rtdb.europe-west1.firebasedatabase.app/';
  //

  Future<void> fetchStudents() async {
    final url = Uri.parse('$_baseUrl/students.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<Student> loadedStudents = [];
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      extractedData.forEach((studentId, studentData) {
        loadedStudents.add(Student(
          id: studentId, // Зберігаємо ідентифікатор студента
          firstName: studentData['firstName'],
          lastName: studentData['lastName'],
          departmentId: studentData['departmentId'],
          gender: Gender.values.firstWhere((e) => e.toString() == studentData['gender']),
          grade: studentData['grade'],
        ));
      });
      state = loadedStudents;
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<void> addStudent(Student student) async {
    final url = Uri.parse('$_baseUrl/students.json');
    final response = await http.post(
      url,
      body: jsonEncode({
        'firstName': student.firstName,
        'lastName': student.lastName,
        'departmentId': student.departmentId,
        'gender': student.gender.toString(),
        'grade': student.grade,
      }),
    );

    if (response.statusCode == 200) {
      final newStudent = student.copyWith(id: jsonDecode(response.body)['name']);
      state = [...state, newStudent];
    } else {
      throw Exception('Failed to add student');
    }
  }

  Future<void> editStudent(Student student, int index) async {
    final url = Uri.parse('$_baseUrl/students/${student.id}.json');
    final response = await http.put(
      url,
      body: jsonEncode({
        'firstName': student.firstName,
        'lastName': student.lastName,
        'departmentId': student.departmentId,
        'gender': student.gender.toString(),
        'grade': student.grade,
      }),
    );

    if (response.statusCode == 200) {
      final newState = [...state];
      newState[index] = student;
      state = newState;
    } else {
      throw Exception('Failed to edit student');
    }
  }

  Future<void> removeStudent(Student student) async {
    final url = Uri.parse('$_baseUrl/students/${student.id}.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      state = state.where((s) => s.id != student.id).toList();
    } else {
      throw Exception('Failed to delete student');
    }
  }

  void removeStudentLocal(int index) {
    state = state.where((student) => state.indexOf(student) != index).toList();
  }

  void insertStudentLocal(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  return StudentsNotifier(ref, []);
});