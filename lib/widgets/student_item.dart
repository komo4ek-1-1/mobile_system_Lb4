import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // Визначення кольору фону на основі статі
    final itemColor = student.gender == Gender.male ? const Color.fromARGB(255, 68, 164, 233) : const Color.fromARGB(255, 247, 126, 166);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // зміщення тіні
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ім'я та прізвище студента
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${student.firstName} ${student.lastName}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          // Іконка спеціальності та оцінка
          Row(
            children: [
              Icon(
                departmentIcons[student.departmentId] ?? Icons.help_outline,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Text(
                'Grade: ${student.grade}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}