import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:matrimony/add_user.dart';
import 'package:matrimony/user_list.dart';
import 'package:matrimony/Aboutus.dart';
import 'package:matrimony/Favorites.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:intl/intl.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

import 'display_user.dart';

import 'package:lottie/lottie.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard>
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
    0.755,
  ];
  int bottomNavigator_index = 0;

// TRY PICE
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // drawer: D,
          //   extendBody: true,
          //   bottomNavigationBar: Stack(
          //     children:[ CrystalNavigationBar(
          //       currentIndex: bottomNavigator_index,
          //       // indicatorColor: Colors.white,
          //       unselectedItemColor: Color(0xFFF0D2B4),
          //       backgroundColor: Colors.white12.withOpacity(0.1),
          //       outlineBorderColor: Colors.white12.withOpacity(0.5),
          //       borderWidth: 3,
          //       // outlineBorderColor: Color(0xff000000),
          //       onTap: (index) => {
          //         setState(() {
          //           bottomNavigator_index = index;
          //         })
          //       },
          //       items: [
          //         /// Home
          //         CrystalNavigationBarItem(
          //           icon: Icons.dashboard,
          //           unselectedIcon: Icons.dashboard,
          //           selectedColor: Color(0xFFF0D2B4),
          //           badge: Badge(
          //             label: FadeTransition(
          //               opacity: _animation,
          //               child: Text(
          //                 "🧭",
          //                 // "↙️",
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ),
          //
          //
          //         // CrystalNavigationBarItem(icon: );
          //
          //         // CrystalNavigationBarItem(
          //         //   icon: Icons.import_contacts_sharp,//Icons.circle, // Dummy icon
          //         //   // : Text("Home"),
          //         // ),
          //
          //
          //         CrystalNavigationBarItem(
          //           icon: Icons.settings,
          //           unselectedIcon: Icons.settings,
          //           selectedColor: Color(0xFFF0D2B4),
          //           badge: Badge(
          //             label: FadeTransition(
          //               opacity: _animation,
          //               // key: _animation,
          //               child: Text(
          //                 "⚙️",
          //                 style: TextStyle(color: Colors.white,fontSize: 10),
          //               ),
          //             ),
          //           ),
          //         ),
          //
          //         // CrystalNavigationBarItem(
          //         //   icon: IconlyBold.user_2,
          //         //   unselectedIcon: IconlyLight.user,
          //         //   selectedColor: Colors.white,
          //         // ),
          //       ],
          //     ),
          //       Padding(
          //         padding:  EdgeInsets.only(
          //             top:32,
          //             left: 117
          //         ),
          //         child: Text(
          //           "|${DateFormat('Hms').format(time)}|",
          //           style: TextStyle(fontSize: 30,
          //               color: Color(0xFFFDF6F0),
          //               fontWeight: FontWeight.bold,
          //               fontFamily: 'doted'
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          backgroundColor: Color(0xFFFFF8F0),
          appBar: AppBar(
            backgroundColor: Color(0xFF800020),
            title: FadeTransition(
              opacity: _animation,
              child: Center(
                child: Text(
                  'MATRIMONY',
                  style: TextStyle(
                      fontFamily: 'doted',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFF8F0),
                      fontSize: 25),
                  // theme chocolate Color(0xff333333)
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 5.0,
                ),
                child: Stack(children: [

                  WaveWidget(
                    config: CustomConfig(
                      colors: _colors,
                      durations: _durations,
                      heightPercentages: _heightPercentages,
                    ),
                    backgroundColor: _backgroundColor,
                    size: Size(double.infinity, double.infinity),
                    waveAmplitude: 0,
                  ),
                  Lottie.asset("assets/Image/Hearts_feedback.json", height: MediaQuery.of(context).size.height),
                ],),
              ),
              Container(
                height: 450,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          _card("assets/Image/adduser.png", "Add user",
                              () => AddUser()),
                          _card("assets/Image/userlist.png", "User List",
                              () => Display_User(isFavourite: false,))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _card("assets/Image/favorites.png", "Favorites",
                              () => Display_User(isFavourite: true,)),
                          _card("assets/Image/aboutus.png", "About Us",
                              () => AboutUsPage()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Column(
              //   children: [
              //     Expanded(
              //       child: GridView.count(
              //         crossAxisCount: 2,
              //         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         //     crossAxisCount: 2),
              //         children: [
              //           card("assets/Image/adduser.png", "Add user",
              //               () => AddUser()),
              //           card("assets/Image/userlist.png", "User List",
              //               () => user_list()),
              //           card("assets/Image/favorites.png", "Favorites",
              //               () => Favorites()),
              //           card("assets/Image/aboutus.png", "About Us",
              //               () => Aboutus()),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 235.5),
                child: Align(
                  child: Text(
                    "Find Your Perfect Match",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'doted',
                      color: Color(0xFF6B4E3D),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          )),
    );
  }

  Widget _card(image, title, Widget Function() location) {
    return Expanded(
      child: InkWell(
        onTap: () => {
          setState(() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => location()));
          })
        },
        child: Card(
          shadowColor: Colors.purpleAccent.shade100,
          margin: EdgeInsets.all(20),
          elevation: 15,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.shade200,
                      Colors.blue.shade100,
                      Colors.purple.shade100,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                        child: Container(
                      child: Image.asset(image),
                      margin: EdgeInsets.only(top: 10),
                    )),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF333333),
                      // fontFamily: 'doted',
                    ),
                  )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
