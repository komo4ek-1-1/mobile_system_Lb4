import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart';
import '../providers/students_provider.dart';

class DepartmentItem extends ConsumerWidget {
  final Department department;

  const DepartmentItem({super.key, required this.department});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);
    final studentCount = students.where((s) => s.departmentId == department.id).length;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: department.color,
        child: InkWell(
          onTap: () {
            // Додайте логіку для переходу на екран факультету
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(department.icon, size: 40, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  '${department.name} ($studentCount)',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}