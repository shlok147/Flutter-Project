import 'package:flutter/material.dart';

class blink extends StatefulWidget {
  @override
  State<blink> createState() => _blinkState();
}

class _blinkState extends State<blink> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinking AppBar Title',
      home: BlinkingAppBarTitle(),
    );
  }
}

class BlinkingAppBarTitle extends StatefulWidget {
  @override
  _BlinkingAppBarTitleState createState() => _BlinkingAppBarTitleState();
}

class _BlinkingAppBarTitleState extends State<BlinkingAppBarTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Start blinking loop
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: FadeTransition(
            opacity: _animation,
            child: Center(
              child: const Text(
                'Matrimony',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: const Center(child: Text('Body')),
      ),
    );
  }
}
