// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:matrimony/info/DBHelper.dart';
// import 'package:matrimony/info/details.dart';
//
// class UserProfilePage extends StatefulWidget {
//   final int UserID;
//
//   UserProfilePage({super.key,required this.UserID});
//
//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }
//
// class _UserProfilePageState extends State<UserProfilePage> {
//
//   late Future<P_Details> user;
//
//
//   @override
//   void initState() {
//     super.initState();
//     DBHelper db = DBHelper();
//     user = db.getUser(widget.UserID);
//   }
//
//   Widget _buildInfoCard(String title, String value, IconData icon) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: const Color(0xFF800020), size: 28),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black54)),
//                 const SizedBox(height: 4),
//                 Text(value,
//                     style: GoogleFonts.poppins(
//                         fontSize: 16, fontWeight: FontWeight.w500)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: const Color(0xFFFFF8F0),
//   //     appBar: AppBar(
//   //       backgroundColor: const Color(0xFF800020),
//   //       elevation: 4,
//   //       title: Text(
//   //         "User Profile",
//   //         style: GoogleFonts.poppins(
//   //             fontWeight: FontWeight.bold, color: Colors.white),
//   //       ),
//   //       centerTitle: true,
//   //     ),
//   //     body: Stack(
//   //       children: [
//   //         // Background Lottie Animation
//   //         Positioned.fill(
//   //           child: Opacity(
//   //             opacity: 0.15,
//   //             child: Lottie.asset("assets/Image/floating_hearts.json",
//   //                 fit: BoxFit.cover),
//   //           ),
//   //         ),
//   //
//   //         // Main Content
//   //         SingleChildScrollView(
//   //           child: Column(
//   //             children: [
//   //               const SizedBox(height: 20),
//   //
//   //               // Profile Picture
//   //               Center(
//   //                 child: Hero(
//   //                   tag: user!.Name, // unique hero tag from user list
//   //                   child: CircleAvatar(
//   //                     radius: 70,
//   //                     backgroundImage: FileImage(File(user!.ImagePath)),
//   //                   ),
//   //                 ),
//   //               ),
//   //               const SizedBox(height: 12),
//   //               Text(user!.Name,
//   //                   style: GoogleFonts.poppins(
//   //                       fontSize: 22,
//   //                       fontWeight: FontWeight.bold,
//   //                       color: const Color(0xFF800020))),
//   //               const SizedBox(height: 4),
//   //               Text("Matrimonial Member",
//   //                   style: GoogleFonts.poppins(
//   //                       fontSize: 14, color: Colors.black54)),
//   //
//   //               const SizedBox(height: 20),
//   //
//   //               // Info Cards
//   //               _buildInfoCard("📧 Email", user!.Email, Icons.email),
//   //               _buildInfoCard("📱 Mobile", user!.Phone, Icons.phone),
//   //               _buildInfoCard("🎂 Date of Birth", user!.Date_Birth, Icons.cake),
//   //               _buildInfoCard("🏙️ City", user!.City, Icons.location_city),
//   //               _buildInfoCard("⚧ Gender", user!.Gender, Icons.person),
//   //               _buildInfoCard("🎨 Hobbies", jsonDecode(user!.Hobbies), Icons.favorite),
//   //               _buildInfoCard("🔒 Password", user!.Password, Icons.lock),
//   //
//   //               const SizedBox(height: 20),
//   //
//   //               // Edit Button with animation
//   //               ElevatedButton.icon(
//   //                 style: ElevatedButton.styleFrom(
//   //                   backgroundColor: const Color(0xFF800020),
//   //                   shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(12)),
//   //                   padding: const EdgeInsets.symmetric(
//   //                       vertical: 12, horizontal: 24),
//   //                 ),
//   //                 onPressed: () {
//   //                   ScaffoldMessenger.of(context).showSnackBar(
//   //                     const SnackBar(
//   //                         content: Text("Edit Profile feature coming soon ✨")),
//   //                   );
//   //                 },
//   //                 icon: const Icon(Icons.edit, color: Colors.white),
//   //                 label: Text("Edit Profile",
//   //                     style: GoogleFonts.poppins(
//   //                         fontSize: 16,
//   //                         fontWeight: FontWeight.bold,
//   //                         color: Colors.white)),
//   //               ),
//   //               const SizedBox(height: 30),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: const Color(0xFFFFF8F0),
//   //     appBar: AppBar(
//   //       backgroundColor: const Color(0xFF800020),
//   //       elevation: 4,
//   //       title: Text(
//   //         "User Profile",
//   //         style: GoogleFonts.poppins(
//   //             fontWeight: FontWeight.bold, color: Colors.white),
//   //       ),
//   //       centerTitle: true,
//   //     ),
//   //     body: user == null
//   //         ? const Center(child: CircularProgressIndicator())
//   //         : Stack(
//   //       children: [
//   //         // Background Lottie Animation
//   //         Positioned.fill(
//   //           child: Opacity(
//   //             opacity: 0.15,
//   //             child: Lottie.asset("assets/Image/floating_hearts.json",
//   //                 fit: BoxFit.cover),
//   //           ),
//   //         ),
//   //
//   //         // Main Content
//   //         SingleChildScrollView(
//   //           child: Column(
//   //             children: [
//   //               const SizedBox(height: 20),
//   //
//   //               // Profile Picture
//   //               Center(
//   //                 child: CircleAvatar(
//   //                     radius: 70,
//   //                     backgroundImage: FileImage(File(user!.ImagePath)),
//   //                   ),
//   //               ),
//   //               const SizedBox(height: 12),
//   //               Text(user!.Name,
//   //                   style: GoogleFonts.poppins(
//   //                       fontSize: 22,
//   //                       fontWeight: FontWeight.bold,
//   //                       color: const Color(0xFF800020))),
//   //               const SizedBox(height: 4),
//   //               Text("Matrimonial Member",
//   //                   style: GoogleFonts.poppins(
//   //                       fontSize: 14, color: Colors.black54)),
//   //
//   //               const SizedBox(height: 20),
//   //
//   //               // Info Cards
//   //               _buildInfoCard("📧 Email", user!.Email, Icons.email),
//   //               _buildInfoCard("📱 Mobile", user!.Phone, Icons.phone),
//   //               _buildInfoCard(
//   //                   "🎂 Date of Birth", user!.Date_Birth, Icons.cake),
//   //               _buildInfoCard("🏙️ City", user!.City, Icons.location_city),
//   //               _buildInfoCard("⚧ Gender", user!.Gender, Icons.person),
//   //               _buildInfoCard("🎨 Hobbies",
//   //                   jsonDecode(user!.Hobbies), Icons.favorite),
//   //               _buildInfoCard(
//   //                   "🔒 Password", user!.Password, Icons.lock),
//   //
//   //               const SizedBox(height: 20),
//   //
//   //               // Edit Button with animation
//   //               ElevatedButton.icon(
//   //                 style: ElevatedButton.styleFrom(
//   //                   backgroundColor: const Color(0xFF800020),
//   //                   shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(12)),
//   //                   padding: const EdgeInsets.symmetric(
//   //                       vertical: 12, horizontal: 24),
//   //                 ),
//   //                 onPressed: () {
//   //                   ScaffoldMessenger.of(context).showSnackBar(
//   //                     const SnackBar(
//   //                         content: Text(
//   //                             "Edit Profile feature coming soon ✨")),
//   //                   );
//   //                 },
//   //                 icon: const Icon(Icons.edit, color: Colors.white),
//   //                 label: Text("Edit Profile",
//   //                     style: GoogleFonts.poppins(
//   //                         fontSize: 16,
//   //                         fontWeight: FontWeight.bold,
//   //                         color: Colors.white)),
//   //               ),
//   //               const SizedBox(height: 30),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("User Profile")),
//         body: FutureBuilder<P_Details>(
//           future: user,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData) {
//               return Center(child: Text("No user data found."));
//             } else {
//               final user = snapshot.data!;
//               return Stack(
//                 children: [
//                   // Background Lottie Animation
//                   Positioned.fill(
//                     child: Opacity(
//                       opacity: 0.15,
//                       child: Lottie.asset("assets/Image/floating_hearts.json",
//                           fit: BoxFit.cover),
//                     ),
//                   ),
//
//                   // Main Content
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 20),
//
//                         // Profile Picture
//                         Center(
//                           child: CircleAvatar(
//                             radius: 70,
//                             backgroundImage: FileImage(File(user.ImagePath)),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(user.Name,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color(0xFF800020))),
//                         const SizedBox(height: 4),
//                         Text("Matrimonial Member",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, color: Colors.black54)),
//
//                         const SizedBox(height: 20),
//
//                         // Info Cards
//                         _buildInfoCard("📧 Email", user.Email, Icons.email),
//                         _buildInfoCard("📱 Mobile", user.Phone, Icons.phone),
//                         _buildInfoCard(
//                             "🎂 Date of Birth", user.Date_Birth, Icons.cake),
//                         _buildInfoCard("🏙️ City", user.City, Icons.location_city),
//                         _buildInfoCard("⚧ Gender", user.Gender, Icons.person),
//                         _buildInfoCard("🎨 Hobbies",
//                             jsonDecode(user.Hobbies), Icons.favorite),
//                         _buildInfoCard(
//                             "🔒 Password", user.Password, Icons.lock),
//
//                         const SizedBox(height: 20),
//
//                         // Edit Button with animation
//                         ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF800020),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12)),
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 12, horizontal: 24),
//                           ),
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       "Edit Profile feature coming soon ✨")),
//                             );
//                           },
//                           icon: const Icon(Icons.edit, color: Colors.white),
//                           label: Text("Edit Profile",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matrimony/add_user.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrimony/info/DBHelper.dart';
import 'package:matrimony/info/details.dart';

import 'generateBiodataPDF.dart';

class UserProfilePage extends StatefulWidget {
  final int userID;

  const UserProfilePage({super.key, required this.userID});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<P_Details> user;

  @override
  void initState() {
    super.initState();
    DBHelper db = DBHelper();
    user = db.getUser(widget.userID);
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF800020), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
                const SizedBox(height: 4),
                Text(value,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "User Profile",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            SizedBox(
              width: 40,
            )
          ],
        ),
        backgroundColor: Color(0xFF800020),
      ),
      body: FutureBuilder<P_Details>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No user data found."));
          } else {
            final user = snapshot.data!;

            // Safely decode hobbies
            String hobbies = '';
            try {
              hobbies = (jsonDecode(user.Hobbies) as List).join(', ');
            } catch (_) {
              hobbies = user.Hobbies;
            }

            return Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.35,
                    child: Lottie.asset("assets/Image/Hearts_feedback.json",
                        fit: BoxFit.cover),
                  ),
                ),

                // Main Content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: File(user.ImagePath).existsSync()
                              ? FileImage(File(user.ImagePath))
                              : const AssetImage('assets/default_profile.png')
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(user.Name,
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF800020))),
                      const SizedBox(height: 4),
                      Text("Matrimonial Member",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.black54)),

                      const SizedBox(height: 20),

                      // Info Cards
                      _buildInfoCard("📧 Email", user.Email, Icons.email),
                      _buildInfoCard("📱 Mobile", user.Phone, Icons.phone),
                      _buildInfoCard(
                          "🎂 Date of Birth", user.Date_Birth, Icons.cake),
                      _buildInfoCard(
                          "🏙️ City", user.City, Icons.location_city),
                      _buildInfoCard("⚧ Gender", user.Gender, Icons.person),
                      _buildInfoCard("🎨 Hobbies", hobbies, Icons.favorite),
                      _buildInfoCard("🔒 Password", user.Password, Icons.lock),

                      const SizedBox(height: 20),

                      // Edit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF800020),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddUser(
                                        user: user,
                                      )));
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: Text("Edit Profile",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF800020),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            onPressed: () {

                                generateBiodataPDF(user);

                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: Text("Download UserData",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
