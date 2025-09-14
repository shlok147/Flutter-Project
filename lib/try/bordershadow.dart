import 'package:flutter/material.dart';

class br extends StatefulWidget {
  const br({super.key});

  @override
  State<br> createState() => _brState();
}

class _brState extends State<br> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer container for gradient border effect
              Container(
                width: 280,
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF800020), // Top-left (maroon)
                      Color(0xFFFFD1C1), // Bottom-right (peach)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              // Main content container
              // Container(
              //   width: 250,
              //   height: 150,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Gradient Border',
              //       style: TextStyle(
              //         color: Color(0xFF800020),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
