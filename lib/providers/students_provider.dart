import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(this.ref, super.state);

  final Ref ref;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student updatedStudent, int index) {
    final newState = [...state];
    newState[index] = updatedStudent;
    state = newState;
  }

  void insertStudent(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }

  void removeStudent(int index) {
    state = state.where((student) => state.indexOf(student) != index).toList();
  }

  void undoDelete(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  return StudentsNotifier(ref, [
    Student(firstName: 'Олег', lastName: 'Черешниченко', departmentId: '1', gender: Gender.male, grade: 90),
    Student(firstName: 'Дарина', lastName: 'Довгих', departmentId: '2', gender: Gender.female, grade: 85),
    Student(firstName: 'Дарина', lastName: 'Розбийголова', departmentId: '4', gender: Gender.male, grade: 100),
  ]);
});
