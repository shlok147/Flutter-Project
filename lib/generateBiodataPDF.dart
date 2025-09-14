// // import 'dart:io';
// // import 'package:demo/pdf/UserProfile.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/pdf.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:flutter/services.dart' show rootBundle;
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:printing/printing.dart';
// //
// // Future<void> generateBiodataPDF(UserProfile userProfile) async {
// //   final pdf = pw.Document();
// //   final image = userProfile.imagePath.startsWith('http')
// //       ? await networkImage(userProfile.imagePath)
// //       : pw.MemoryImage(File(userProfile.imagePath).readAsBytesSync());
// //
// //   pdf.addPage(
// //     pw.Page(
// //       margin: const pw.EdgeInsets.all(32),
// //       pageFormat: PdfPageFormat.a4,
// //       build: (context) {
// //         return pw.Container(
// //           decoration: pw.BoxDecoration(
// //             border: pw.Border.all(color: PdfColors.grey, width: 2),
// //           ),
// //           padding: const pw.EdgeInsets.all(20),
// //           child: pw.Column(
// //             crossAxisAlignment: pw.CrossAxisAlignment.start,
// //             children: [
// //               // Header
// //               pw.Center(
// //                 child: pw.Text(
// //                   'MATRIMONIAL BIODATA',
// //                   style: pw.TextStyle(
// //                     fontSize: 24,
// //                     fontWeight: pw.FontWeight.bold,
// //                     color: PdfColors.deepPurple,
// //                   ),
// //                 ),
// //               ),
// //               pw.SizedBox(height: 20),
// //
// //               // Profile Picture & Name
// //               pw.Row(
// //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                 children: [
// //                   pw.Container(
// //                     width: 100,
// //                     height: 100,
// //                     decoration: pw.BoxDecoration(
// //                       shape: pw.BoxShape.circle,
// //                       image: pw.DecorationImage(
// //                         image: image,
// //                         fit: pw.BoxFit.cover,
// //                       ),
// //                     ),
// //                   ),
// //                   pw.SizedBox(width: 20),
// //                   pw.Column(
// //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
// //                     children: [
// //                       pw.Text('Name: ${userProfile.name}', style: pw.TextStyle(fontSize: 16)),
// //                       pw.Text('Gender: ${userProfile.gender}', style: pw.TextStyle(fontSize: 16)),
// //                       pw.Text('Date of Birth: ${userProfile.dob}', style: pw.TextStyle(fontSize: 16)),
// //                       pw.Text('City: ${userProfile.city}', style: pw.TextStyle(fontSize: 16)),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               pw.SizedBox(height: 20),
// //
// //               // Contact Details
// //               pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
// //               pw.SizedBox(height: 10),
// //               pw.Text('Email: ${userProfile.email}', style: pw.TextStyle(fontSize: 16)),
// //               pw.Text('Phone: ${userProfile.phoneNumber}', style: pw.TextStyle(fontSize: 16)),
// //
// //               pw.SizedBox(height: 20),
// //
// //               // Hobbies
// //               pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
// //               pw.SizedBox(height: 10),
// //               pw.Bullet(
// //                 text: userProfile.hobbies.join(', '),
// //                 style: pw.TextStyle(fontSize: 16),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     ),
// //   );
// //
// //   // Ask storage permission
// //   final status = await Permission.storage.request();
// //   if (status.isGranted) {
// //     final directory = await getExternalStorageDirectory();
// //     final filePath = '${directory!.path}/${userProfile.name}_Biodata.pdf';
// //
// //     final file = File(filePath);
// //     await file.writeAsBytes(await pdf.save());
// //
// //     print('PDF saved to $filePath');
// //   } else {
// //     print('Permission denied');
// //   }
// // }
//
// import 'dart:io';
// import 'dart:typed_data'; // Required for Uint8List
// import 'package:demo/pdf/UserProfile.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:printing/printing.dart';
//
// Future<void> generateBiodataPDF(UserProfile userProfile) async {
//   final pdf = pw.Document();
//
//   // === MODIFIED IMAGE LOADING LOGIC ===
//   final pw.ImageProvider image;
//
//   if (userProfile.imagePath.startsWith('http')) {
//     // Case 1: Network Image
//     image = await networkImage(userProfile.imagePath);
//   } else if (userProfile.imagePath.startsWith('assets/')) {
//     // Case 2: Asset Image (NEW)
//     final ByteData byteData = await rootBundle.load(userProfile.imagePath);
//     final Uint8List uint8List = byteData.buffer.asUint8List();
//     image = pw.MemoryImage(uint8List);
//   } else {
//     // Case 3: Local File Image
//     image = pw.MemoryImage(File(userProfile.imagePath).readAsBytesSync());
//   }
//   // ===================================
//
//   pdf.addPage(
//     pw.Page(
//       margin: const pw.EdgeInsets.all(32),
//       pageFormat: PdfPageFormat.a4,
//       build: (context) {
//         return pw.Container(
//           decoration: pw.BoxDecoration(
//             border: pw.Border.all(color: PdfColors.grey, width: 2),
//           ),
//           padding: const pw.EdgeInsets.all(20),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               // Header
//               pw.Center(
//                 child: pw.Text(
//                   'MATRIMONIAL BIODATA',
//                   style: pw.TextStyle(
//                     fontSize: 24,
//                     fontWeight: pw.FontWeight.bold,
//                     color: PdfColors.deepPurple,
//                   ),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//
//               // Profile Picture & Name
//               pw.Row(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.Container(
//                     width: 100,
//                     height: 100,
//                     decoration: pw.BoxDecoration(
//                       shape: pw.BoxShape.circle,
//                       image: pw.DecorationImage(
//                         image: image, // Use the loaded image provider
//                         fit: pw.BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   pw.SizedBox(width: 20),
//                   pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text('Name: ${userProfile.name}', style: pw.TextStyle(fontSize: 16)),
//                       pw.Text('Gender: ${userProfile.gender}', style: pw.TextStyle(fontSize: 16)),
//                       pw.Text('Date of Birth: ${userProfile.dob}', style: pw.TextStyle(fontSize: 16)),
//                       pw.Text('City: ${userProfile.city}', style: pw.TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 20),
//
//               // Contact Details
//               pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Text('Email: ${userProfile.email}', style: pw.TextStyle(fontSize: 16)),
//               pw.Text('Phone: ${userProfile.phoneNumber}', style: pw.TextStyle(fontSize: 16)),
//
//               pw.SizedBox(height: 20),
//
//               // Hobbies
//               pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Bullet(
//                 text: userProfile.hobbies.join(', '),
//                 style: pw.TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
//
//   // Ask storage permission
//   final status = await Permission.storage.request();
//   if (status.isGranted) {
//     final directory = await getExternalStorageDirectory();
//     final filePath = '${directory!.path}/${userProfile.name}_Biodata.pdf';
//
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//
//     print('PDF saved to $filePath');
//   } else {
//     print('Permission denied');
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show ByteData, rootBundle;
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:printing/printing.dart'; // Optional: For preview
// import 'package:demo/pdf/UserProfile.dart';
//
// Future<void> generateBiodataPDF(UserProfile userProfile) async {
//   final pdf = pw.Document();
//
//   try {
//     // === Load Image ===
//     final pw.ImageProvider image;
//     if (userProfile.imagePath.startsWith('http')) {
//       image = await networkImage(userProfile.imagePath);
//     } else if (userProfile.imagePath.startsWith('assets/')) {
//       final ByteData byteData = await rootBundle.load(userProfile.imagePath);
//       final Uint8List uint8List = byteData.buffer.asUint8List();
//       image = pw.MemoryImage(uint8List);
//     } else if (userProfile.imagePath.startsWith('data:image')) {
//       // Handle base64 image
//       final base64Str = userProfile.imagePath.split(',').last;
//       final imageBytes = base64Decode(base64Str);
//       image = pw.MemoryImage(imageBytes);
//     } else {
//       image = pw.MemoryImage(File(userProfile.imagePath).readAsBytesSync());
//     }
//
//     // === PDF Page ===
//     pdf.addPage(
//       pw.Page(
//         margin: const pw.EdgeInsets.all(32),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(
//               border: pw.Border.all(color: PdfColors.grey, width: 2),
//             ),
//             padding: const pw.EdgeInsets.all(20),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Center(
//                   child: pw.Text(
//                     'MATRIMONIAL BIODATA',
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.deepPurple,
//                     ),
//                   ),
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Container(
//                       width: 100,
//                       height: 100,
//                       decoration: pw.BoxDecoration(
//                         shape: pw.BoxShape.circle,
//                         image: pw.DecorationImage(
//                           image: image,
//                           fit: pw.BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(width: 20),
//                     pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text('Name: ${userProfile.name}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Gender: ${userProfile.gender}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Date of Birth: ${userProfile.dob}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('City: ${userProfile.city}', style: pw.TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ],
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Email: ${userProfile.email}', style: pw.TextStyle(fontSize: 16)),
//                 pw.Text('Phone: ${userProfile.phoneNumber}', style: pw.TextStyle(fontSize: 16)),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(userProfile.hobbies.join(', '), style: pw.TextStyle(fontSize: 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // === Ask for Permission ===
//     final storagePermission = await Permission.manageExternalStorage.request();
//     if (!storagePermission.isGranted) {
//       print('Permission denied');
//       return;
//     }
//
//     // === Get Proper Downloads Directory (Android) ===
//     final Directory? directory = await getExternalStorageDirectory();
//     if (directory == null) {
//       print('Cannot get external storage directory');
//       return;
//     }
//
//     final downloadsDir = Directory('/storage/emulated/0/Download');
//     if (!(await downloadsDir.exists())) {
//       await downloadsDir.create(recursive: true);
//     }
//
//     final fileName = '${userProfile.name}_Biodata.pdf';
//     final filePath = '${downloadsDir.path}/$fileName';
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//
//     print('✅ PDF saved to: $filePath');
//   } catch (e) {
//     print('❌ Error generating PDF: $e');
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show ByteData, rootBundle;
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:printing/printing.dart'; // Optional: For preview
// import 'package:demo/pdf/UserProfile.dart';
//
// Future<void> generateBiodataPDF(UserProfile userProfile) async {
//   final pdf = pw.Document();
//
//   try {
//     // === Load Image (No changes here) ===
//     final pw.ImageProvider image;
//     if (userProfile.imagePath.startsWith('http')) {
//       image = await networkImage(userProfile.imagePath);
//     } else if (userProfile.imagePath.startsWith('assets/')) {
//       final ByteData byteData = await rootBundle.load(userProfile.imagePath);
//       final Uint8List uint8List = byteData.buffer.asUint8List();
//       image = pw.MemoryImage(uint8List);
//     } else if (userProfile.imagePath.startsWith('data:image')) {
//       final base64Str = userProfile.imagePath.split(',').last;
//       final imageBytes = base64Decode(base64Str);
//       image = pw.MemoryImage(imageBytes);
//     } else {
//       image = pw.MemoryImage(File(userProfile.imagePath).readAsBytesSync());
//     }
//
//     // === PDF Page (No changes here) ===
//     pdf.addPage(
//       pw.Page(
//         margin: const pw.EdgeInsets.all(32),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(
//               border: pw.Border.all(color: PdfColors.grey, width: 2),
//             ),
//             padding: const pw.EdgeInsets.all(20),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Center(
//                   child: pw.Text(
//                     'MATRIMONIAL BIODATA',
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.deepPurple,
//                     ),
//                   ),
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Container(
//                       width: 100,
//                       height: 100,
//                       decoration: pw.BoxDecoration(
//                         shape: pw.BoxShape.circle,
//                         image: pw.DecorationImage(
//                           image: image,
//                           fit: pw.BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(width: 20),
//                     pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text('Name: ${userProfile.name}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Gender: ${userProfile.gender}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Date of Birth: ${userProfile.dob}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('City: ${userProfile.city}', style: pw.TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ],
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Email: ${userProfile.email}', style: pw.TextStyle(fontSize: 16)),
//                 pw.Text('Phone: ${userProfile.phoneNumber}', style: pw.TextStyle(fontSize: 16)),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(userProfile.hobbies.join(', '), style: pw.TextStyle(fontSize: 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // ================== MODIFIED SECTION: Permissions & Saving File ==================
//
//     // 1. Request storage permission
//     // Using Permission.storage is generally sufficient and better than manageExternalStorage.
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       print('Permission denied');
//       return;
//     }
//
//     // 2. Get the public downloads directory
//     // This is the reliable way to get the Downloads folder.
//     final List<Directory>? directories = await getExternalStorageDirectories(type: StorageDirectory.downloads);
//     if (directories == null || directories.isEmpty) {
//       print('Cannot get downloads directory');
//       return;
//     }
//     final Directory downloadsDir = directories.first;
//
//
//     // 3. Create the file path and save the file
//     final fileName = '${userProfile.name}_Biodata.pdf';
//     final filePath = '${downloadsDir.path}/$fileName';
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//
//     print('✅ PDF saved successfully to: $filePath');
//
//     // =================================== END OF MODIFIED SECTION ===================================
//
//   } catch (e) {
//     print('❌ Error generating or saving PDF: $e');
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show ByteData, rootBundle;
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// // No longer need permission_handler for this!
// import 'package:path_provider/path_provider.dart';
// import 'package:printing/printing.dart';
// import 'package:demo/pdf/UserProfile.dart';
//
// Future<void> generateBiodataPDF(UserProfile userProfile) async {
//   final pdf = pw.Document();
//
//   try {
//     // === Load Image (No changes here) ===
//     final pw.ImageProvider image;
//     if (userProfile.imagePath.startsWith('http')) {
//       image = await networkImage(userProfile.imagePath);
//     } else if (userProfile.imagePath.startsWith('assets/')) {
//       final ByteData byteData = await rootBundle.load(userProfile.imagePath);
//       final Uint8List uint8List = byteData.buffer.asUint8List();
//       image = pw.MemoryImage(uint8List);
//     } else if (userProfile.imagePath.startsWith('data:image')) {
//       final base64Str = userProfile.imagePath.split(',').last;
//       final imageBytes = base64Decode(base64Str);
//       image = pw.MemoryImage(imageBytes);
//     } else {
//       image = pw.MemoryImage(File(userProfile.imagePath).readAsBytesSync());
//     }
//
//     // === PDF Page (No changes here) ===
//     pdf.addPage(
//       pw.Page(
//         // ... your page build logic ...
//         margin: const pw.EdgeInsets.all(32),
//         pageFormat: PdfPageFormat.a4,
//         build: (context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(
//               border: pw.Border.all(color: PdfColors.grey, width: 2),
//             ),
//             padding: const pw.EdgeInsets.all(20),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Center(
//                   child: pw.Text(
//                     'MATRIMONIAL BIODATA',
//                     style: pw.TextStyle(
//                       fontSize: 24,
//                       fontWeight: pw.FontWeight.bold,
//                       color: PdfColors.deepPurple,
//                     ),
//                   ),
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Container(
//                       width: 100,
//                       height: 100,
//                       decoration: pw.BoxDecoration(
//                         shape: pw.BoxShape.circle,
//                         image: pw.DecorationImage(
//                           image: image,
//                           fit: pw.BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(width: 20),
//                     pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text('Name: ${userProfile.name}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Gender: ${userProfile.gender}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('Date of Birth: ${userProfile.dob}', style: pw.TextStyle(fontSize: 16)),
//                         pw.Text('City: ${userProfile.city}', style: pw.TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ],
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text('Email: ${userProfile.email}', style: pw.TextStyle(fontSize: 16)),
//                 pw.Text('Phone: ${userProfile.phoneNumber}', style: pw.TextStyle(fontSize: 16)),
//                 pw.SizedBox(height: 20),
//                 pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//                 pw.SizedBox(height: 10),
//                 pw.Text(userProfile.hobbies.join(', '), style: pw.TextStyle(fontSize: 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // ================== SIMPLIFIED Saving Logic ==================
//
//     // 1. Get the public downloads directory (no permissions needed)
//     final List<Directory>? directories = await getExternalStorageDirectories(type: StorageDirectory.downloads);
//     if (directories == null || directories.isEmpty) {
//       print('Cannot get downloads directory');
//       return;
//     }
//     final Directory downloadsDir = directories.first;
//
//     // 2. Create the file path and save the file
//     final fileName = '${userProfile.name}_Biodata.pdf';
//     final filePath = '${downloadsDir.path}/$fileName';
//     final file = File(filePath);
//     await file.writeAsBytes(await pdf.save());
//
//     print('✅ PDF saved successfully to: $filePath');
//
//   } catch (e) {
//     print('❌ Error generating or saving PDF: $e');
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:matrimony/info/details.dart';


Future<void> generateBiodataPDF(P_Details user) async {
  final pdf = pw.Document();

  try {
    final pw.ImageProvider image;
    if (user.ImagePath.startsWith('http')) {
      image = await networkImage(user.ImagePath);
    } else if (user.ImagePath.startsWith('assets/')) {
      final ByteData byteData = await rootBundle.load(user.ImagePath);
      final Uint8List uint8List = byteData.buffer.asUint8List();
      image = pw.MemoryImage(uint8List);
    } else if (user.ImagePath.startsWith('data:image')) {
      final base64Str = user.ImagePath.split(',').last;
      final imageBytes = base64Decode(base64Str);
      image = pw.MemoryImage(imageBytes);
    } else {
      // Assumes the path is a local file path
      image = pw.MemoryImage(File(user.ImagePath).readAsBytesSync());
    }

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(32),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey, width: 2),
            ),
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Center(
                  child: pw.Text(
                    'MATRIMONIAL BIODATA',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.deepPurple,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),

                // Main Info Section
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        image: pw.DecorationImage(
                          image: image,
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Name: ${user.Name}', style: pw.TextStyle(fontSize: 16)),
                        pw.Text('Gender: ${user.Gender}', style: pw.TextStyle(fontSize: 16)),
                        pw.Text('Date of Birth: ${user.Date_Birth}', style: pw.TextStyle(fontSize: 16)),
                        pw.Text('City: ${user.City}', style: pw.TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                // Contact Details
                pw.Text('Contact Information', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('Email: ${user.Email}', style: pw.TextStyle(fontSize: 16)),
                pw.Text('Phone: ${user.Phone}', style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 20),

                // Hobbies
                pw.Text('Hobbies', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(jsonDecode(user.Hobbies), style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );

    final List<Directory>? directories = await getExternalStorageDirectories(type: StorageDirectory.downloads);
    if (directories == null || directories.isEmpty) {
      print('❌ Cannot get downloads directory');
      return;
    }
    final Directory downloadsDir = directories.first;

    final fileName = '${user.Name}_Biodata.pdf';
    final filePath = '${downloadsDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    print('✅ PDF saved successfully to: $filePath');

  } catch (e) {
    print('❌ Error generating or saving PDF: $e');
  }
}