import 'package:flutter/material.dart';
import 'navigation.dart';

class SettingsPage extends StatefulWidget {
  final AppNavigator navigator;

  const SettingsPage({Key? key, required this.navigator}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double frequency = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Testing Frequency', style: TextStyle(fontSize: 24)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Slider(
                value: frequency,
                min: 0,
                max: 3,
                divisions: 3,
                label: '${frequency.toInt()}',
                onChanged: (double value) {
                  frequency = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Go back to home page'),
              onPressed: () {
                widget.navigator.goBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}
