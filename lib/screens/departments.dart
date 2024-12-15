import 'package:flutter/material.dart';
import '../models/department.dart';
import '../widgets/department_item.dart';

class DepartmentsScreen extends StatelessWidget {
  final List<Department> departments = [
    Department(
      id: '1',
      name: 'Finance',
      color: Colors.green,
      icon: Icons.attach_money,
    ),
    Department(
      id: '2',
      name: 'Law',
      color: Colors.blue,
      icon: Icons.gavel,
    ),
    Department(
      id: '3',
      name: 'IT',
      color: Colors.red,
      icon: Icons.computer,
    ),
    Department(
      id: '4',
      name: 'Medical',
      color: Colors.purple,
      icon: Icons.local_hospital,
    ),
  ];

  DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: departments.length,
      itemBuilder: (ctx, index) {
        return DepartmentItem(department: departments[index]);
      },
    );
  }
}