import 'package:flutter/material.dart';


class check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: Text("Text Above BottomNavigationBar")),
      body: Center(child: Text("Main Content")),

      // Place Text above BottomNavigationBar like a vertical stack
      bottomNavigationBar: Stack(
        // mainAxisSize: MainAxisSize.min,
        children: [
          // This is your custom text
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Hello from bottom!",
              style: TextStyle(fontSize: 16),
            ),
          ),

          // Then the BottomNavigationBar
          BottomNavigationBar(
            backgroundColor: Colors.white12.withOpacity(0.1),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
