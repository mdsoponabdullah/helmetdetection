import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  List<String> items = [
    "Item 1",
    "item 2",
  ];
  @override
  Widget build(BuildContext context) {
    return Material( // Wrap with Material widget
      child: RefreshIndicator(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.all(5),
              child: ListTile(
                title: Text(items[index]),
              ),
            ))),
        onRefresh: () async {
          // Simulate delay
          await Future.delayed(const Duration(seconds: 2));

          // Add new item
          int nextItem = items.length + 1;
          items.add("item ${nextItem}");
          setState(() {});
        },
      ),
    );
  }
}
