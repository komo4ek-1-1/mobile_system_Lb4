import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/departments.dart';
import 'widgets/students.dart';

final ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    headlineSmall: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
  ),
);


/*final ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.latoTextTheme(),
); */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      theme: theme,      
      home: const TabsScreen(),
    );
  }
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  TabsScreenState createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DepartmentsScreen(),
    const StudentsScreen(),
  ];

  final List<String> _titles = [
    'Departments',
    ' ',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex], 
        style: Theme.of(context).textTheme.titleMedium),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Departments',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Students',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
