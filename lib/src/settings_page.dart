import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:permission_handler/permission_handler.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),
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
              onPressed: () async {
                if (await Permission.microphone.isGranted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Microphone permissions already granted.'),
                    ),
                  );
                } else {
                  if (await Permission.microphone.request().isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Microphone permissions granted.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Microphone permissions denied.'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Grant Microphone Permissions'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (await Permission.microphone.isGranted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Storage permissions already granted.'),
                    ),
                  );
                } else {
                  if (await Permission.storage.request().isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Storage permissions granted.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Storage permissions denied.'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Grant Storage Permissions'),
            ),
          ],
        ),
      ),
    );
  }
}
