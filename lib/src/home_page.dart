import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:voice_check/src/test_page.dart';

class HomePage extends StatefulWidget {
  final AppNavigator navigator;

  HomePage({Key? key, required this.navigator}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<String>> items = [
    ['3/8/2023', '87'],
    ['3/7/2023', '85'],
    ['3/6/2023', '93'],
  ];

  void addItem(List<double> newItem) {
    setState(() {
      items.insert(0, ['5/1/2023', newItem[0].toString()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.connect_without_contact_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TestPage(
                  navigator: widget.navigator,
                  onSubmitted: addItem,
                ),
              ),
            );
          },
        ),
        title: const Text(
          'VoiceCheck',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              widget.navigator.navigateTo('/settings');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              for (var i = 0; i < items.length; i++)
                Column(
                  children: [
                    ListTile(
                      title: Text('5/1/2023'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WPM: 100'),
                          Text('Matched WPM: 50'),
                          Text('Mean pauses: 40'),
                          Text('STDev pauses: 3'),
                          Text('Intelligibility: Fair'),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
