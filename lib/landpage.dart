import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:matrimony/setting.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';

// void main() {
//   runApp(landpage());
// }

class landpage extends StatelessWidget {
  const landpage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff800020)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Matrimonial'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
// try pice

  late AnimationController _controller;
  late Animation<double> _animation;

  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Start blinking loop
    _controller.repeat(reverse: true);

    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  static const _backgroundColor = Color(0xFFFFF8F0);

  static const _colors = [
    Color(0xFFF0D2B4),
    Color(0xFFAA5C3C),
    Color(0xFF660022),
  ];

  static const _durations = [
    3000,
    3000,
    3000,
  ];

  static const _heightPercentages = [
    0.52,
    0.63,
    0.77,
  ];

  int bottomNavigator_index = 0;

  List<Widget> screens = [dashboard(), setting()];

// TRY PICE
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // drawer: D,
        extendBody: true,
        bottomNavigationBar: Stack(
          children: [
            CrystalNavigationBar(
              currentIndex: bottomNavigator_index,
              // indicatorColor: Colors.white,
              unselectedItemColor: Color(0xFFF0D2B4),
              backgroundColor: bottomNavigator_index % 2 == 0
                  ? Colors.white12.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              outlineBorderColor: bottomNavigator_index % 2 == 0
                  ? Colors.white12.withOpacity(0.5)
                  : Color(0xFF660022),
              //.withOpacity(0.5),
              borderWidth: 3,
              // outlineBorderColor: Color(0xff000000),
              onTap: (index) => {
                setState(() {
                  bottomNavigator_index = index;
                })
              },
              items: [
                /// Home
                CrystalNavigationBarItem(
                  icon: Icons.dashboard,
                  unselectedIcon: Icons.dashboard,
                  selectedColor: bottomNavigator_index == 0
                      ? Color(0xFFF0D2B4)
                      : Color(0xFF660022),
                  unselectedColor: bottomNavigator_index == 0
                      ? Color(0xFFF0D2B4)
                      : Color(0xFF660022),
                  badge: Badge(
                    backgroundColor: bottomNavigator_index == 0
                        ? Colors.transparent
                        : Color(0xFFF0D2B4),
                    label: FadeTransition(
                      opacity: _animation,
                      child: Text(
                        "🧭",
                        // "↙️",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                CrystalNavigationBarItem(
                  icon: Icons.settings,
                  unselectedIcon: Icons.settings,
                  selectedColor: bottomNavigator_index == 0
                      ? Color(0xFFF0D2B4)
                      : Color(0xFF660022),
                  unselectedColor: bottomNavigator_index == 0
                      ? Color(0xFFF0D2B4)
                      : Color(0xFF660022),
                  badge: Badge(
                    backgroundColor: bottomNavigator_index == 0
                        ? Colors.transparent
                        : Color(0xFFF0D2B4),
                    label: FadeTransition(
                      opacity: _animation,
                      // key: _animation,
                      child: Text(
                        "⚙️",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, left: 117),
              child: Text(
                "|${DateFormat('Hms').format(time)}|",
                style: TextStyle(
                    fontSize: 30,
                    color: bottomNavigator_index == 0
                        ? Color(0xFFFDF6F0)
                        : Color(0xFFAA5C3C),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'doted'),
              ),
            )
          ],
        ),
        backgroundColor: Color(0xFFFFF8F0),

        body: screens[bottomNavigator_index],
      ),
    );
  }
}
