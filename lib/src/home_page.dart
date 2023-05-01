import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:voice_check/src/test_page.dart';

class ScoreData {
  String date;
  double wpm;
  double mwpm;
  double meanPauses;
  double stdevPauses;
  String intelligibility;

  ScoreData({
    required this.date,
    required this.wpm,
    required this.mwpm,
    required this.meanPauses,
    required this.stdevPauses,
    required this.intelligibility,
  });
}

class HomePage extends StatefulWidget {
  final AppNavigator navigator;

  HomePage({Key? key, required this.navigator}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ScoreData> items = [];
  bool isAnalyzingResult = false;

  void addItem() async {
    setState(() {
      isAnalyzingResult = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      isAnalyzingResult = false;
      items.insert(
        0,
        ScoreData(
          date: '5/1/2023',
          wpm: 100.0,
          mwpm: 60.0,
          meanPauses: 5.0,
          stdevPauses: 1.5,
          intelligibility: 'Fair',
        ),
      );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              if (isAnalyzingResult) const Text('Analyzing latest test'),
              if (isAnalyzingResult) const SizedBox(height: 20.0),
              for (var i = 0; i < items.length; i++)
                Column(
                  children: [
                    ListTile(
                      title: Text(items.elementAt(i).date),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WPM: ${items.elementAt(i).wpm}'),
                          Text('Matched WPM: ${items.elementAt(i).mwpm}'),
                          Text('Mean pauses: ${items.elementAt(i).meanPauses}'),
                          Text(
                              'STDev pauses: ${items.elementAt(i).stdevPauses}'),
                          Text(
                              'Intelligibility: ${items.elementAt(i).intelligibility}'),
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
