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
