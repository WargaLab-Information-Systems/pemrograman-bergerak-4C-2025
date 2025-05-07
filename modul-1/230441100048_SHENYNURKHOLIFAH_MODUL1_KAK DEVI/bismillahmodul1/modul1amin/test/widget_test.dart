// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modul1amin/main.dart';

void main() {
  testWidgets('Navigasi ke DetailPage saat Hot Place diklik', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const MyTravelApp()); // atau MyTravelApp jika itu nama class-nya

    // Cari teks 'National Park'
    final hotPlace = find.text('National Park');

    // Pastikan teks ditemukan
    expect(hotPlace, findsOneWidget);

    // Tap item tersebut
    await tester.tap(hotPlace);
    await tester.pumpAndSettle(); // Tunggu animasi selesai

    // Pastikan navigasi ke halaman detail berhasil
    expect(find.text('National Park Yosemite'), findsOneWidget);
  });
}
