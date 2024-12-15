import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../models/department.dart';

class DepartmentItem extends StatelessWidget {
  final Department department;

  const DepartmentItem({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: department.color,
      child: InkWell(
        onTap: () {
          // Додайте логіку для переходу на екран факультету
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(department.icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                department.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                /*style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}