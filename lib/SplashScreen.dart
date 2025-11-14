import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'landpage.dart';
  
  class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
      super.initState();
      _navigateToHome();
    }
  
    _navigateToHome() async {
      await Future.delayed(Duration(milliseconds: 3000), () {}); // Simulate loading time
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => landpage()), // Replace with your actual Home Screen
      );
    }
  
    @override
    Widget build(BuildContext context) {
      // Define your theme colors
      final Color appBarColor = Color(0xFF800020);
      final Color bodyColor = Color(0xFFFFF8F0);
      final Color accentColor = Color(0xFFD4AF37); // A rich gold for accents
  
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Background Gradient
            Container(
              decoration: BoxDecoration(
                // gradient:
                gradient: LinearGradient(
                  colors: [appBarColor, bodyColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
  
            // Rive Animated Background (Optional)
            // Ensure 'assets/rive/sparkle_background.riv' exists
            // If you don't have a Rive file, remove this Widget.
            // Center(
            //   child: RiveAnimation.asset(
            //     'assets/rive/sparkle_background.riv',
            //     fit: BoxFit.cover,
            //     alignment: Alignment.center,
            //   ),
            // ),
  
            // Content of the Splash Screen
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Central Intertwined Logo (as shown in the image)
                // This would typically be an SVG or custom painter for scalability.
                // For simplicity, let's use placeholder Text or an Image.
                // If you have the actual logo as SVG, use 'flutter_svg' package.
                Hero(
                  tag: 'appLogo', // For a smooth transition to the next screen
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First intertwined shape (dark)
                        Text(
                          'ॐ', // Placeholder for the intricate shape
                          style: TextStyle(
                            fontFamily: 'CustomSymbolFont', // Use a custom font that has this symbol or similar
                            fontSize: 100,
                            color: appBarColor,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                        // Second intertwined shape (light)
                        Text(
                          'ੴ', // Placeholder for the intricate shape
                          style: TextStyle(
                            fontFamily: 'CustomSymbolFont', // Use a custom font that has this symbol or similar
                            fontSize: 100,
                            color: bodyColor,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
  
                // App Name
                Hero(
                  tag: 'appName', // For a smooth transition
                  child: Material(
                    color: Colors.transparent, // Important for Hero animation
                    child: Text(
                      'SAPATAPADI', // Replace with your app name
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay', // Example elegant serif font
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: accentColor, // Gold color for prominence
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
  
                // Tagline
                Text(
                  'Your Journey to Togetherness Begins',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat', // Example lighter font
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: bodyColor.withOpacity(0.8),
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
  
                // Loading Indicator
                SpinKitFadingCircle(
                  color: accentColor,
                  size: 50.0,
                ),
  
                // Small Lotus Icon at the bottom
                SizedBox(height: 50),
                Icon(
                  Icons.spa, // Placeholder, ideally a custom SVG asset for a lotus
                  size: 40,
                  color: accentColor.withOpacity(0.7),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
  
  // // Dummy Home Screen for navigation
  // class HomeScreen extends StatelessWidget {
  //   @override
  //   Widget build(BuildContext context) {
  //     final Color appBarColor = Color(0xFF800020);
  //     final Color bodyColor = Color(0xFFFFF8F0);
  //
  //     return Scaffold(
  //         appBar: AppBar(
  //           backgroundColor: appBarColor,
  //           title: Text(
  //             'SAPATAPADI Home',
  //             style: TextStyle(color: bodyColor),
  //           ),
  //         ),
  //         body: Container(
  //           color: bodyColor,
  //           child: Center(
  //             child: Text(
  //               'Welcome to your Matrimonial App!',
  //               style: TextStyle(fontSize: 24, color: appBarColor),
  //             ),
  //           ),
  //         ),
  //     );
  //   }
  // }