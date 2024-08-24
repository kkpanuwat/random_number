import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Random Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _results = [];

  void _calculate() {
    setState(() {
      _results.clear();
      String number = _controller.text;

      final digits = number.split('');
      final combinations = <String>{};

      for (int i = 0; i < digits.length; i++) {
        for (int j = 0; j < digits.length; j++) {
          for (int k = 0; k < digits.length; k++) {
            if (i != j && j != k && i != k) {
              final combination = '${digits[i]}${digits[j]}${digits[k]}';
              final sortedCombination = _sortString(combination);
              combinations.add(sortedCombination);
            }
          }
        }
      }

      _results = combinations.toList()..sort();
    });
  }

  // Helper function to sort the characters of a string
  String _sortString(String input) {
    List<String> characters = input.split('');
    characters.sort();
    return characters.join('');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double elementWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '123456',
                    ),
                  ),
                  SizedBox(height: 16), // Space between TextField and Button
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0D7C66), // Background color
                      minimumSize:
                          Size(double.infinity, 36), // Match TextField width
                    ),
                    child: const Text(
                      'คำนวณ',
                      style: TextStyle(color: Colors.white, height: 3),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${index + 1}. ${_results[index]}',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
