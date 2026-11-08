import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:confetti/confetti.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final String instagramAppUrl = "instagram://user?username=shlok_charola_04";
  final String instagramUrl = "https://www.instagram.com/shlok_charola_04";
  final String snapchatUrl = "https://www.snapchat.com/add/shlok_charola";
  final String snapchatAppUrl = "snapchat://add/shlok_charola";
  final String linkedinUrl = "https://www.linkedin.com/in/shlok-charola-05a287316?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app";
  final String linkedinAppUrl = "linkedin://profile/shlok-charola-05a287316";
  final String linktreeUrl = "https://linktr.ee/SHLOK_CHAROLA";
  final String facebookUrl = "https://www.facebook.com/share/1KqiKbpLR5/";
  final String facebookAppUrl = "fb://page/1KqiKbpLR5";



  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    Future.delayed(const Duration(seconds: 1), () {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  static Future<void> launchAppOrWeb({
    required String appUrl,
    required String webUrl,
  }) async {
    final Uri appUri = Uri.parse(appUrl);
    final Uri webUri = Uri.parse(webUrl);

    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Color(0xFF800020),
        elevation: 8,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🌹"),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.redAccent,
                child: Text(
                  " About Us ",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Text("💌"),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // // Top Animation
                // Lottie.asset("assets/Image/love_letter.json", height: 200),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),

                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.5,
                              color: Colors.black,
                            )
                          ),
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.black,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/Image/darshanUniversity.jpg"),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            )
                          ),
                          child: Image.asset(
                            "assets/Image/aswdc.png",
                            fit: BoxFit.cover,
                          ),
                        )),
                      ]),
                ),

                // Profile Picture with Glow
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF800020),
                        Color(0xFFFDF6F0),
                        Color(0xFFAA5C3C),
                        Color(0xFFF0D2B4),
                        Color(0xFF800020),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        AssetImage("assets/Image/profilephoto.jpg"),
                  ),
                ),
                const SizedBox(height: 15),

                // Funny Tagline
                Text(
                  "Helping people find love 💕\nBecause WiFi can’t connect souls 😉",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 25),

                // Developer Info Card
                _buildCard(
                  title: "👨‍💻 Developer Info",
                  description:
                      "Hi, I’m SHLOK CHAROLA 👋\nA code wizard who brews apps like coffee ☕.\n"
                      "This app helps you find love faster than my code compiles 🚀.",
                  lottie: "assets/Image/Heart_fav.json",
                ),
                const SizedBox(height: 20),

                // App Info Card
                _buildCard(
                  title: "📱 About the App",
                  description:
                      "This matrimonial app blends tradition with technology 💍.\n"
                      "Swipe, laugh, and connect with your soulmate 💃🕺.\n"
                      "Plus—animations to keep the romance alive ✨.",
                  lottie: "assets/Image/wedding_ring.json",
                ),
                const SizedBox(height: 25),

                // Social Media
                Text(
                  "🌐 Connect With Me",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF800020),
                  ),
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              "assets/Image/Hearts_feedback.json",
                              height: 100),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.instagram,
                              color: Colors.purple),
                          iconSize: 32,
                          onPressed: () => launchAppOrWeb(appUrl: instagramAppUrl,webUrl: instagramUrl),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.snapchat,
                              color: Colors.yellow),
                          iconSize: 32,
                          onPressed: () => launchAppOrWeb(webUrl: snapchatAppUrl,appUrl: snapchatUrl),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.linkedin,
                              color: Colors.blue),
                          iconSize: 32,
                          onPressed: () => launchAppOrWeb(appUrl: linkedinAppUrl,webUrl: linkedinUrl),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.link,
                              color: Colors.green),
                          iconSize: 32,
                          onPressed: () => openUrl(linktreeUrl),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook,
                              color: Colors.blueAccent),
                          iconSize: 32,
                          onPressed: () => launchAppOrWeb(webUrl: facebookUrl,appUrl: facebookAppUrl),
                        ),
                      ],
                    ),
                  ],
                ),
                // const SizedBox(height: 30),

                const SizedBox(height: 10),
                Text(
                  "“Love is in the air… and also in this app 💖”",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            colors: const [Colors.pink, Colors.red, Colors.orange],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      {required String title,
      required String description,
      required String lottie}) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF800020),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Lottie.asset(lottie, height: 100),
        ],
      ),
    );
  }
}
