// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:aplication_modul1/main.dart';

void main() {
  testWidgets('Main screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Cek apakah teks "Hi, User" muncul
    expect(find.text('Hi, User'), findsOneWidget);

    // Cek apakah section "Hot Places" dan "Best Hotels" muncul
    expect(find.text('Hot Places'), findsOneWidget);
    expect(find.text('Best Hotels'), findsOneWidget);

    // Cek apakah "See All" muncul dua kali (atas dan bawah)
    expect(find.text('See All'), findsNWidgets(2));
  });
}
