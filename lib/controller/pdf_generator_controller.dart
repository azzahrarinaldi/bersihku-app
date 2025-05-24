import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:bersihku/models/detail_laporan_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

class PdfGeneratorController extends GetxController {
  // Untuk menandai saat PDF sedang diproses
  final RxBool isGenerating = false.obs;

  Future<void> generatePdfFile({
    required List<DetailLaporanModel> laporanList,
    required String selectedBulan,
    required String selectedWilayah,
    required bool isDaily,
  }) async {
    if (isDaily || selectedWilayah == 'Semua') {
      Get.snackbar(
        'Oops',
        'Ganti ke Laporan Bulanan dan pilih wilayah dulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      return;
    }

    try {
      isGenerating.value = true; 

      // 1. Hitung total berat sampah (basah + kering)
      final totalSemua = laporanList
        .map((d) => d.weightBasah + d.weightKering)
        .fold<double>(0, (sum, w) => sum + w);
      
      final formattedTotalSemua = totalSemua % 1 == 0
        ? totalSemua.toInt().toString()
        : totalSemua.toStringAsFixed(2);

      // 2. Buat dokumen PDF baru
      final pdf = pw.Document();
      final dfTgl = DateFormat('d MMM yyyy', 'id');
      final rawLogo = await rootBundle.load('assets/images/logo.png'); 
      final logoImage = pw.MemoryImage(rawLogo.buffer.asUint8List());
      final gambarBasahList = <List<pw.MemoryImage>>[];
      final gambarKeringList = <List<pw.MemoryImage>>[];

      for (var d in laporanList) { 
        final basah = await Future.wait(
          d.imagesBasah.map((url) async {
            final res = await http.get(Uri.parse(url));
            return pw.MemoryImage(res.bodyBytes);
          }),
        );
        final kering = await Future.wait(
          d.imagesKering.map((url) async {
            final res = await http.get(Uri.parse(url));
            return pw.MemoryImage(res.bodyBytes);
          }),
        );
        gambarBasahList.add(basah);
        gambarKeringList.add(kering);
      }

      // 5. Tambahkan halaman MultiPage (landscape A4)
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (_) => [
            // HEADER: judul, info wilayah & bulan, total berat, dan logo
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'LAPORAN BULANAN',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text('Lokasi: $selectedWilayah'),
                    pw.Text('Bulan:   $selectedBulan'),
                    pw.Text('Total Berat Semua Sampah: $formattedTotalSemua kg'),
                  ],
                ),
                pw.Image(logoImage, width: 80),
              ],
            ),
            pw.SizedBox(height: 16),
            // TABEL: header row + data rows
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey),
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              columnWidths: {
                0: pw.FlexColumnWidth(0.5),
                1: pw.FlexColumnWidth(1.2),
                2: pw.FlexColumnWidth(1.4),
                3: pw.FlexColumnWidth(0.8),
                4: pw.FlexColumnWidth(2),
                5: pw.FlexColumnWidth(),
                6: pw.FlexColumnWidth(0.8),
                7: pw.FlexColumnWidth(2),
                8: pw.FlexColumnWidth(2),
              },
              children: [
                // Baris HEADER dengan warna background abu-abu
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    'NO',
                    'TGL',
                    'NAMA',
                    'TSB',
                    'Sampah Basah Sebelum Diangkut',
                    'Sampah Basah Sesudah Diangkut',
                    'TSK',
                    'Sampah Kering Sebelum Diangkut',
                    'Sampah Kering Sesudah Diangkut',
                  ].map((text) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        text,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        textAlign: pw.TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                // Baris DATA: looping sesuai jumlah laporan
                for (var i = 0; i < laporanList.length; i++)
                  pw.TableRow(
                    children: [
                      // Kolom NO
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${i + 1}', textAlign: pw.TextAlign.center),
                      ),
                      // Kolom TGL
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(dfTgl.format(laporanList[i].createdAt), textAlign: pw.TextAlign.center),
                      ),
                      // Kolom NAMA
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(laporanList[i].name, textAlign: pw.TextAlign.center),
                      ),
                      // Kolom total basah
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${laporanList[i].formattedWeightBasah} kg', textAlign: pw.TextAlign.center),
                      ),
                      // Gambar basah sebelum
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Container(
                          height: 60,
                          child: pw.Image(gambarBasahList[i][0], fit: pw.BoxFit.cover),
                        ),
                      ),
                      // Gambar basah sesudah
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Container(
                          height: 60,
                          child: pw.Image(gambarBasahList[i][1], fit: pw.BoxFit.cover),
                        ),
                      ),
                      // Kolom total kering
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('${laporanList[i].formattedWeightKering} kg', textAlign: pw.TextAlign.center),
                      ),
                      // Gambar kering sebelum
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Container(
                          height: 60,
                          child: pw.Image(gambarKeringList[i][0], fit: pw.BoxFit.cover),
                        ),
                      ),
                      // Gambar kering sesudah
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Container(
                          height: 60,
                          child: pw.Image(gambarKeringList[i][1], fit: pw.BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      );

      // 6. Simpan file PDF ke direktori aplikasi dan buka
      final dir = await getApplicationDocumentsDirectory();
      final safeRegion = selectedWilayah.replaceAll(' ', '_');
      final fileName = 'Laporan_Pengangkutan_Sampah_${safeRegion}_$selectedBulan.pdf';
      final outFile = File('${dir.path}/$fileName');

      // Tulis data PDF ke file
      await outFile.writeAsBytes(await pdf.save());

      // Buka file PDF secara otomatis
      await OpenFile.open(outFile.path);
    } catch (e) {
      // Jika ada kesalahan saat generate atau simpan
      Get.snackbar(
        'Error',
        'Gagal generate atau simpan PDF: \$e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Matikan loading indicator meski sukses atau error
      isGenerating.value = false;
    }
  }
}