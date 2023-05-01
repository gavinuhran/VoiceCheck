import 'package:flutter/material.dart';
import 'navigation.dart';

class HomePage extends StatelessWidget {
  final AppNavigator navigator;
  final List<List<String>> items = [
    ['3/8/2023', '87'],
    ['3/7/2023', '85'],
    ['3/6/2023', '93'],
    ['3/5/2023', '88'],
    ['3/4/2023', '79'],
    ['3/3/2023', '85'],
    ['3/8/2023', '87'],
    ['3/7/2023', '85'],
    ['3/6/2023', '93'],
    ['3/5/2023', '88'],
    ['3/4/2023', '79'],
    ['3/3/2023', '85'],
    ['3/8/2023', '87'],
    ['3/7/2023', '85'],
    ['3/6/2023', '93'],
    ['3/5/2023', '88'],
    ['3/4/2023', '79'],
    ['3/3/2023', '85'],
    ['3/8/2023', '87'],
    ['3/7/2023', '85'],
    ['3/6/2023', '93'],
    ['3/5/2023', '88'],
    ['3/4/2023', '79'],
    ['3/3/2023', '85'],
  ];

  HomePage({Key? key, required this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.connect_without_contact_rounded),
          onPressed: () {
            navigator.navigateTo('/test');
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
              navigator.navigateTo('/settings');
            },
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Score: ${items[index][1]}'),
                subtitle: Text(items[index][0]),
              );
            },
          ),
        ),
      ),
    );
  }
}
