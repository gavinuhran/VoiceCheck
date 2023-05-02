import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:voice_check/src/record_and_play_audio.dart';

class MySlider extends StatefulWidget {
  Function() sliderGetter;
  Function(double) sliderSetter;

  MySlider({required this.sliderGetter, required this.sliderSetter});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.sliderGetter(),
      min: 1,
      max: 10,
      divisions: 9,
      onChanged: (newValue) {
        widget.sliderSetter(newValue);
      },
    );
  }
}

class TestPage extends StatefulWidget {
  final AppNavigator navigator;
  final Function(List<double>) onSubmitted;
  final Function(String) filePathSetter;

  TestPage({
    required this.navigator,
    required this.onSubmitted,
    required this.filePathSetter,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final PageController controller = PageController(initialPage: 0);
  int index = 0;
  double sliderOne = 5.0;
  double sliderTwo = 5.0;
  double sliderThree = 5.0;

  double getSliderOne() {
    return sliderOne;
  }

  void setSliderOne(double value) {
    setState(() {
      sliderOne = value;
    });
  }

  double getSliderTwo() {
    return sliderTwo;
  }

  void setSliderTwo(double value) {
    setState(() {
      sliderTwo = value;
    });
  }

  double getSliderThree() {
    return sliderThree;
  }

  void setSliderThree(double value) {
    setState(() {
      sliderThree = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Column(
        children: [
          const Expanded(
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
          RecordAndPlayScreen(
            filePathSetter: widget.filePathSetter,
          ),
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
          const SizedBox(height: 60.0),
          MySlider(
            sliderGetter: getSliderOne,
            sliderSetter: setSliderOne,
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
          const SizedBox(height: 60.0),
          MySlider(
            sliderGetter: getSliderTwo,
            sliderSetter: setSliderTwo,
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
          const SizedBox(height: 60.0),
          MySlider(
            sliderGetter: getSliderThree,
            sliderSetter: setSliderThree,
          ),
        ],
      ),
    ];

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
          if (index >= 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  index--;
                });
              },
              child: const Text('Previous'),
            ),
          if (index >= 1) const SizedBox(width: 10.0),
          if (index < pages.length - 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  index++;
                });
              },
              child: const Text('Next'),
            ),
          if (index == pages.length - 1) const SizedBox(width: 10.0),
          if (index == pages.length - 1)
            ElevatedButton(
              onPressed: () {
                List<double> sliderValues = [];
                sliderValues.add(getSliderOne());
                sliderValues.add(getSliderTwo());
                sliderValues.add(getSliderThree());
                widget.onSubmitted(sliderValues);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
        ],
      ),
    );
  }
}
