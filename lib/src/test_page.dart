import 'package:flutter/material.dart';
import 'navigation.dart';

class TestPage extends StatelessWidget {
  final AppNavigator navigator;

  const TestPage({Key? key, required this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at dictum dui, at tristique urna. Nulla feugiat pharetra vestibulum. Cras dapibus, eros a accumsan cursus, sapien nisl porta augue, id efficitur velit elit vitae ligula. Nullam ac dictum nunc. In hac habitasse platea dictumst. Donec dictum ligula vel feugiat consequat. Nam cursus non felis id aliquet. Nam consectetur scelerisque sem, id laoreet est fringilla et.',
                style: TextStyle(
                  fontSize: 20,
                  height: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                child: const Text('Record speech'), onPressed: () {}),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Go back to home page'),
              onPressed: () {
                navigator.goBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}
