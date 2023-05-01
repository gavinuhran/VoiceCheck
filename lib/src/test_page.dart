import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'navigation.dart';
import 'package:provider/provider.dart';
import 'package:voice_check/src/play_audio_provider.dart';
import 'package:voice_check/src/record_audio_provider.dart';
import 'package:voice_check/src/record_and_play_audio.dart';
import 'package:flutter/foundation.dart';

class SliderValues extends ChangeNotifier {
  double slider1Value = 5;
  double slider2Value = 5;
  double slider3Value = 5;

  void setSlider1Value(double value) {
    slider1Value = value;
    notifyListeners();
  }

  void setSlider2Value(double value) {
    slider2Value = value;
    notifyListeners();
  }

  void setSlider3Value(double value) {
    slider3Value = value;
    notifyListeners();
  }
}

class SliderWidget extends StatelessWidget {
  final double initialValue;
  final Function(double) onValueChanged;

  const SliderWidget(
      {Key? key, required this.initialValue, required this.onValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final values = Provider.of<SliderValues>(context, listen: false);

    return Column(
      children: [
        Text('Select a number between 1 and 10'),
        Consumer<SliderValues>(
          builder: (context, sliderValues, child) {
            return Slider(
              value: sliderValues.slider1Value,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: onValueChanged,
            );
          },
        ),
      ],
    );
  }
}

class TestPage extends StatefulWidget {
  final AppNavigator navigator;
  final Function(List<double>) onSubmitted;

  TestPage({required this.navigator, required this.onSubmitted});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController controller = PageController(initialPage: 0);
  final SliderValues values = SliderValues();
  int index = 0;

  final List<Widget> pages = [
    Column(
      children: const [
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at dictum dui, at tristique urna. Nulla feugiat pharetra vestibulum. Cras dapibus, eros a accumsan cursus, sapien nisl porta augue, id efficitur velit elit vitae ligula. Nullam ac dictum nunc. In hac habitasse platea dictumst. Donec dictum ligula vel feugiat consequat. Nam cursus non felis id aliquet. Nam consectetur scelerisque sem, id laoreet est fringilla et.',
              style: TextStyle(
                fontSize: 20,
                height: 2,
              ),
            ),
          ),
        ),
        RecordAndPlayScreen(),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'How effective do YOU feel that your communication has been?',
          style: TextStyle(
            fontSize: 20,
            height: 2,
          ),
        ),
        SizedBox(height: 60.0),
        Consumer<SliderValues>(
          builder: (context, sliderValues, _) {
            return SliderWidget(
              initialValue: sliderValues.slider1Value,
              onValueChanged: (double value) {
                sliderValues.slider1Value = value;
              },
            );
          },
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'How effective do your family and friends feel that your communication has been?',
          style: TextStyle(
            fontSize: 20,
            height: 2,
          ),
        ),
        SizedBox(height: 60.0),
        Consumer<SliderValues>(
          builder: (context, sliderValues, _) {
            return SliderWidget(
              initialValue: sliderValues.slider2Value,
              onValueChanged: (double value) {
                sliderValues.slider2Value = value;
              },
            );
          },
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'To what extent is your ability to communicate vocally negatively affecting your quality of life?',
          style: TextStyle(
            fontSize: 20,
            height: 2,
          ),
        ),
        SizedBox(height: 60.0),
        Consumer<SliderValues>(
          builder: (context, sliderValues, _) {
            return SliderWidget(
              initialValue: sliderValues.slider3Value,
              onValueChanged: (double value) {
                sliderValues.slider3Value = value;
              },
            );
          },
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm cancellation'),
                  content: const Text(
                      'Your unfinished results will not be recorded.\n\nAre you sure you want to end your testing procedure prematurely?'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/');
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Vocal Test',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: pages[index]),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (index > 1)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Previous'),
            ),
          if (index < pages.length - 1)
            ElevatedButton(
              onPressed: () {
                if (index < pages.length - 1) {
                  setState(() {
                    index++;
                  });
                }
              },
              child: const Text('Next'),
            ),
          if (index == pages.length - 1)
            ElevatedButton(
              onPressed: () {
                widget.onSubmitted([
                  values.slider1Value,
                  values.slider2Value,
                  values.slider3Value,
                ]);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
        ],
      ),
    );
  }
}
