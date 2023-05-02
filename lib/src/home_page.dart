import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:voice_check/src/test_page.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String filePath = '';

  Future<Map<String, dynamic>> sendAudio() async {
    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5000/send-audio/'),
    );

    // Attach the audio file to the request
    var audioFile = File(filePath);
    var audioStream = http.ByteStream(audioFile.openRead());
    var audioLength = await audioFile.length();
    var audioMultipart = http.MultipartFile(
      'file',
      audioStream,
      audioLength,
      filename: audioFile.path.split('/').last,
    );
    request.files.add(audioMultipart);

    // Send the request
    var response = await request.send();

    // Read the response as a string
    var responseString = await response.stream.bytesToString();

    // Convert the response string to JSON
    var responseJson = jsonDecode(responseString);

    // Handle the response
    return responseJson;
  }

  void setFilePath(String path) {
    setState(() {
      filePath = path;
    });
  }

  void addItem() async {
    setState(() {
      isAnalyzingResult = true;
    });

    var results = await sendAudio();

    setState(() {
      isAnalyzingResult = false;
      items.insert(
        0,
        ScoreData(
          date: results['date'],
          wpm: results['WPM'],
          mwpm: results['Matched WPM'],
          meanPauses: results['Mean Pauses'],
          stdevPauses: results['STDev Pauses'],
          intelligibility: results['Intelligibility'],
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
                  filePathSetter: setFilePath,
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
