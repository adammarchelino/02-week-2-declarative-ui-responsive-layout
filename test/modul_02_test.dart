import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poliwangi_mobile_starter/modul_02/models/course.dart';
import 'package:poliwangi_mobile_starter/modul_02/widgets/course_card.dart';
import 'package:poliwangi_mobile_starter/modul_02/widgets/header_banner.dart';
import 'package:poliwangi_mobile_starter/modul_02/academic_dashboard_screen.dart';

void main() {
  group('Modul 02 Autograding: Declarative UI & Responsive Layout', () {
    test('1. Model Course mengembalikan daftar data sample valid', () {
      final sample = Course.getSampleCourses();
      expect(sample.length, greaterThanOrEqualTo(4));
      expect(sample.first.code, equals('TRPL501'));
      expect(sample.first.sks, greaterThan(0));
    });

    testWidgets('2. CourseCard merender nama mata kuliah, dosen, dan badge SKS',
        (WidgetTester tester) async {
      const course = Course(
        code: 'TEST101',
        name: 'Algoritma Pemrograman',
        lecturer: 'Dosen Penguji',
        sks: 3,
        progress: 0.5,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CourseCard(course: course)),
        ),
      );

      expect(find.text('TEST101'), findsOneWidget);
      expect(find.text('Algoritma Pemrograman'), findsOneWidget);
      expect(find.text('Dosen Penguji'), findsOneWidget);
      expect(find.text('3 SKS'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets(
        '3. AcademicDashboardScreen adaptif: 1 kolom di mobile (<600dp), 2 kolom di tablet (>=600dp)',
        (WidgetTester tester) async {
      // Test mobile size (400 x 800)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester
          .pumpWidget(const MaterialApp(home: AcademicDashboardScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GridView), findsNothing);

      // Test tablet/desktop size (800 x 600)
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester
          .pumpWidget(const MaterialApp(home: AcademicDashboardScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      // Reset physical size
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });

    testWidgets('4. Filter kategori hanya menampilkan mata kuliah yang sesuai',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester
          .pumpWidget(const MaterialApp(home: AcademicDashboardScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Praktikum'));
      await tester.pumpAndSettle();

      expect(find.text('TRPL501'), findsOneWidget);
      expect(find.text('TRPL504'), findsOneWidget);
      expect(find.text('TRPL502'), findsNothing);
      expect(find.text('TRPL503'), findsNothing);

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });

    testWidgets('5. CourseCard membuka bottom sheet rincian saat diketuk',
        (WidgetTester tester) async {
      const course = Course(
        code: 'TEST101',
        name: 'Algoritma Pemrograman',
        lecturer: 'Dosen Penguji',
        sks: 3,
        progress: 0.5,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: CourseCard(course: course)),
        ),
      );

      await tester.tap(find.text('TEST101'));
      await tester.pumpAndSettle();

      expect(find.text('TEST101 - Algoritma Pemrograman'), findsOneWidget);
      expect(find.text('Dosen Penguji'), findsNWidgets(2));
      expect(find.text('Tutup Rincian'), findsOneWidget);
    });

    testWidgets(
        '6. HeaderBanner menampilkan peringatan jika total SKS lebih dari 24',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HeaderBanner(totalSks: 25)),
        ),
      );

      expect(
        find.text(
            'Peringatan: Total SKS melebihi batas maksimal 24 SKS per semester!'),
        findsOneWidget,
      );
    });

    testWidgets('7. Tombol AppBar mengganti mode terang dan gelap',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: AcademicDashboardScreen()));

      expect(find.byTooltip('Mode Gelap'), findsOneWidget);

      await tester.tap(find.byTooltip('Mode Gelap'));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Mode Terang'), findsOneWidget);
    });
  });
}
