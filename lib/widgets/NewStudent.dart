import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/departments_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  final Student? student; // Якщо null, то це додавання; якщо є - редагування
  final Function(Student) onSave; // Callback для збереження студента

  const NewStudent({super.key, this.student, required this.onSave});

  @override
  ConsumerState<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  // Контролери для текстових полів
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String? _selectedDepartmentId; // Вибраний департамент
  Gender? _selectedGender; // Вибрана стать
  int _grade = 0; // Початкова оцінка

  @override
  void initState() {
    super.initState();

    // Якщо редагуємо існуючого студента, заповнюємо поля
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartmentId = widget.student!.departmentId;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  void _saveStudent() {
    if (_selectedDepartmentId == null || _selectedGender == null) {
      // Перевірка на заповненість полів
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Створюємо нового студента
    final newStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      departmentId: _selectedDepartmentId!,
      gender: _selectedGender!,
      grade: _grade,
    );

    widget.onSave(newStudent); // Викликаємо callback
    Navigator.of(context).pop(); // Закриваємо модальне вікно
  }

  @override
  Widget build(BuildContext context) {
    final departments = ref.watch(departmentsProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Робимо вікно компактним
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          DropdownButtonFormField<String>(
            value: _selectedDepartmentId,
            decoration: const InputDecoration(labelText: 'Select Department'),
            items: departments.map((dept) {
              return DropdownMenuItem(
                value: dept.id,
                child: Text(dept.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDepartmentId = value;
              });
            },
          ),
          DropdownButtonFormField<Gender>(
            value: _selectedGender,
            decoration: const InputDecoration(labelText: 'Select Gender'),
            items: Gender.values.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
          Slider(
            value: _grade.toDouble(),
            min: 0,
            max: 100,
            divisions: 100,
            label: '$_grade',
            onChanged: (value) {
              setState(() {
                _grade = value.toInt();
              });
            },
          ),
          ElevatedButton(
            onPressed: _saveStudent,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
