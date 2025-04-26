import 'package:bersihku/const.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_field_row.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_section.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/image_placeholder.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/location_dropdown.dart';
import 'package:bersihku/ui/user-front/succes-screen/succes_screen.dart';
import 'package:flutter/material.dart';

class LaporanPengangkutanScreen extends StatefulWidget {
  const LaporanPengangkutanScreen({Key? key}) : super(key: key);

  @override
  State<LaporanPengangkutanScreen> createState() =>
      _LaporanPengangkutanScreenState();
}

class _LaporanPengangkutanScreenState extends State<LaporanPengangkutanScreen> {
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController platController = TextEditingController();
  final TextEditingController beratKeseluruhanController =
      TextEditingController();
  final TextEditingController beratKeringController = TextEditingController();
  final TextEditingController beratBasahController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     double screenWidth = size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Laporan Pengangkutan',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // padding kiri-kanan 5%
            vertical: 15, // padding atas-bawah tetap bisa disesuaikan
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Lokasi Drop Point",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              LocationDropdown(onChanged: (val) {
                print(val);
              }),
              const SizedBox(height: 16),
              FieldWithLabel(
                  label: "Nomor Plat Truk",
                  controller: platController,
                  spacing: 100),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: "Total Berat Keseluruhan",
                controller: beratKeseluruhanController,
                spacing: 70,
                suffixText: "Kg",
              ),
              const SizedBox(height: 24),
              const FormSectionTitle(
                  title: "Sampah Kering", color: secondaryColor),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: "Total Berat",
                controller: beratKeringController,
                spacing: 160,
                suffixText: "Kg",
              ),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(
                  title: "Foto Sampah Sebelum Diangkat"),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(
                  title: "Foto Sampah Sesudah Diangkat"),
              const SizedBox(height: 24),
              const FormSectionTitle(
                  title: "Sampah Basah", color: Colors.orange),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: "Total Berat",
                controller: beratKeringController,
                spacing: 160,
                suffixText: "Kg",
              ),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(
                  title: "Foto Sampah Sebelum Diangkat"),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(
                  title: "Foto Sampah Sesudah Diangkat"),
              const SizedBox(height: 24),
              Text(
                "Catatan",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'tambahkan Catatan',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: true,
                  ),
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuccesScreen()),
                    );
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
