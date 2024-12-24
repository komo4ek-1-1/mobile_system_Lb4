import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/students_provider.dart';
import 'student_item.dart';
import 'NewStudent.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  bool _isLoading = false;
  Student? _recentlyDeletedStudent; // Зберігає видаленого студента для Undo
  int? _recentlyDeletedIndex; // Зберігає індекс видаленого студента

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await ref.read(studentsProvider.notifier).fetchStudents();
    } catch (error) {
      // Handle error
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _addStudent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewStudent(
          onSave: (newStudent) {
            ref.read(studentsProvider.notifier).addStudent(newStudent);
          },
        );
      },
    );
  }

  void _editStudent(Student student, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return NewStudent(
          student: student,
          onSave: (updatedStudent) {
            ref.read(studentsProvider.notifier).editStudent(updatedStudent, index);
          },
        );
      },
    );
  }

  void _deleteStudent(int index) {
    final students = ref.read(studentsProvider);
    setState(() {
      _recentlyDeletedStudent = students[index];
      _recentlyDeletedIndex = index;
    });
    ref.read(studentsProvider.notifier).removeStudentLocal(index);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Deleted ${_recentlyDeletedStudent!.firstName} ${_recentlyDeletedStudent!.lastName}',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: _undoDelete,
        ),
        duration: const Duration(seconds: 3),
      ),
    ).closed.then((value) {
      if (value != SnackBarClosedReason.action) {
        ref.read(studentsProvider.notifier).removeStudent(_recentlyDeletedStudent!);
      }
    });
  }

  void _undoDelete() {
    if (_recentlyDeletedStudent != null && _recentlyDeletedIndex != null) {
      ref.read(studentsProvider.notifier).insertStudentLocal(_recentlyDeletedStudent!, _recentlyDeletedIndex!);
      setState(() {
        _recentlyDeletedStudent = null;
        _recentlyDeletedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addStudent,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: students.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: ValueKey(
                      students[index].firstName + students[index].lastName + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteStudent(index);
                  },
                  child: InkWell(
                    onTap: () => _editStudent(students[index], index),
                    child: StudentItem(student: students[index]),
                  ),
                );
              },
              separatorBuilder: (ctx, index) =>
                  Divider(height: 1, color: Colors.grey[300]),
            ),
    );
  }
}