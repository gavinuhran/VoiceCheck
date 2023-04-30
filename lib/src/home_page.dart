import 'package:flutter/material.dart';
import 'navigation.dart';

class HomePage extends StatelessWidget {
  final AppNavigator navigator;

  const HomePage({Key? key, required this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Time until next test: 0s',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Test voice'),
                onPressed: () {
                  navigator.navigateTo('/test');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Past results'),
                onPressed: () {
                  navigator.navigateTo('/results');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  navigator.navigateTo('/settings');
                },
                child: const Text('Settings'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
