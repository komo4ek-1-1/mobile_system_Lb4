import 'package:flutter/material.dart';
import '../models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentsProvider = Provider<List<Department>>((ref) {
  return [
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
});
