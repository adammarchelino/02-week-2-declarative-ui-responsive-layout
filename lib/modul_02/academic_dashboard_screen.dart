import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() =>
      _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState extends State<AcademicDashboardScreen> {
  final List<Course> _courses = Course.getSampleCourses();
  bool _isDarkMode = false;
  String _selectedCategory = 'Semua';

  List<Course> get _filteredCourses {
    if (_selectedCategory == 'Semua') {
      return _courses;
    }
    return _courses
        .where((course) => course.category == _selectedCategory)
        .toList();
  }

  int get _totalSks => _courses.fold(0, (sum, course) => sum + course.sks);

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  Widget _buildCategoryFilter() {
    const categories = ['Semua', 'Teori', 'Praktikum'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        return ChoiceChip(
          label: Text(category),
          selected: _selectedCategory == category,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedCategory = category;
              });
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildCourseList({required bool grid}) {
    final courses = _filteredCourses;

    if (courses.isEmpty) {
      return const Center(
        child: Text('Belum ada mata kuliah pada kategori ini.'),
      );
    }

    if (grid) {
      return GridView.builder(
        padding: const EdgeInsets.only(top: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 230,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) => CourseCard(course: courses[index]),
      );
    }

    return Column(
      children: courses.map((course) => CourseCard(course: course)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard Akademik TRPL',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0284C7),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded),
              tooltip: _isDarkMode ? 'Mode Terang' : 'Mode Gelap',
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        // LayoutBuilder membaca ukuran layar untuk menentukan tata letak responsif
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Breakpoint 600dp: Tablet / Landscape menggunakan 2 kolom
            if (constraints.maxWidth >= 600) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kolom kiri: banner profil
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: HeaderBanner(totalSks: _totalSks),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Kolom kanan: grid 2 kolom daftar mata kuliah
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCategoryFilter(),
                          Expanded(child: _buildCourseList(grid: true)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            // Default (smartphone): tata letak 1 kolom vertikal
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                HeaderBanner(totalSks: _totalSks),
                const SizedBox(height: 16),
                Text(
                  'Mata Kuliah Semester 5 (${_filteredCourses.length} Terdaftar)',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildCategoryFilter(),
                const SizedBox(height: 12),
                _buildCourseList(grid: false),
              ],
            );
          },
        ),
      ),
    );
  }
}
