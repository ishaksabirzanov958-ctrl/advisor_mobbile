import 'package:flutter/material.dart';
import 'screens/register_screen.dart';

// main() — Flutter колдонмосунун иштеп баштаган жери, Java'дагы
// AdvisorApplication.main() сыяктуу эле.
void main() {
  runApp(const AdvisorMobileApp());
}

// AdvisorMobileApp — бүт колдонмонун "тамыр" виджети. Бул жерден
// глобалдык стилдер, тема жана биринчи ачылуучу экран тууралайт.
class AdvisorMobileApp extends StatelessWidget {
  const AdvisorMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Career Advisor',
      theme: ThemeData(
        // colorSchemeSeed — бир түстөн бүт колдонмо үчүн гармониялуу
        // палитра куруп берет, ар бир баскычка өзүнчө түс тандабай.
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      // Колдонмо ачылганда биринчи көрүнүүчү экран — катталуу.
      home: const RegisterScreen(),
    );
  }
}
