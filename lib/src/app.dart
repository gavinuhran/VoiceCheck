import 'package:flutter/material.dart';
import 'navigation.dart';
import 'home_page.dart';
import 'test_page.dart';
import 'results_page.dart';
import 'settings_page.dart';

class VoiceCheck extends StatelessWidget {
  VoiceCheck({super.key});

  final AppNavigator navigator = AppNavigator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigator Example',
      navigatorKey: navigator.navigatorKey,
      routes: {
        '/': (BuildContext context) => HomePage(navigator: navigator),
        '/test': (BuildContext context) => TestPage(navigator: navigator),
        '/results': (BuildContext context) => ResultsPage(navigator: navigator),
        '/settings': (BuildContext context) =>
            SettingsPage(navigator: navigator),
      },
    );
  }
}

class VoiceCheckState extends ChangeNotifier {}
