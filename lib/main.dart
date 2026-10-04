import 'package:flutter/material.dart';
import 'new_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color bgRedColor = Colors.red;
  Color bgWhiteColor = Colors.white;
  bool isRed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isRed ? bgRedColor : bgWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'This is the title',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: const [
          Icon(
            Icons.wifi,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRed = !isRed;
                });
              },
              child: const Text('Click me if you dare'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NewPage(
                        isRed: isRed,
                      );
                    },
                  ),
                );
              },
              child: const Text('go to the next page'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.ads_click),
            ),
            Center(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9sTyyC7H9Bl4XCXz2r6dBgnd_n1PDd3MxTU6mFNW31A&s',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}