import 'package:flutter/material.dart';
import 'navigation.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'package:provider/provider.dart';
import 'package:voice_check/src/play_audio_provider.dart';
import 'package:voice_check/src/record_audio_provider.dart';
import 'package:voice_check/src/test_page.dart';

class VoiceCheck extends StatelessWidget {
  VoiceCheck({super.key});

  final AppNavigator navigator = AppNavigator();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Navigator Example',
        navigatorKey: navigator.navigatorKey,
        routes: {
          '/': (BuildContext context) => HomePage(navigator: navigator),
          '/settings': (BuildContext context) =>
              SettingsPage(navigator: navigator),
        },
      ),
    );
  }
}

class VoiceCheckState extends ChangeNotifier {}
