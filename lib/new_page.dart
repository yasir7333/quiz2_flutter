import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({
    super.key,
    required this.isRed,
  });

  final bool isRed;

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isRed ? Colors.red : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('New page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          TextButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('go to the next page'),
          ),
          Text(textEditingController.text),
        ],
      ),
    );
  }
}