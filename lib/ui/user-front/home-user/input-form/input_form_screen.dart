import 'package:bersihku/const.dart';
import 'package:flutter/material.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_field_row.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/form_section.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/image_placeholder.dart';
import 'package:bersihku/ui/user-front/home-user/input-form/components/location_dropdown.dart';
import 'package:bersihku/ui/user-front/succes-screen/succes_screen.dart';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({Key? key}) : super(key: key);

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController platController = TextEditingController();
  final TextEditingController beratKeseluruhanController = TextEditingController();
  final TextEditingController beratKeringController = TextEditingController();
  final TextEditingController beratBasahController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  String? selectedLocation;

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
          horizontal: screenWidth * 0.05, 
          vertical: 15, 
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Lokasi Drop Point",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              LocationDropdown(
                onChanged: (val) {
                  selectedLocation = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Lokasi harus dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FieldWithLabel(
                  label: "Nomor Plat Truk",
                  controller: platController,
                  spacing: 100,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Harus diisi';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: "Total Berat Keseluruhan",
                controller: beratKeseluruhanController,
                spacing: 70,
                suffixText: "Kg",
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
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
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(title: "Foto Sampah Sebelum Diangkat"),
              const SizedBox(height: 20),
              const UploadImagePlaceholder(title: "Foto Sampah Sesudah Diangkat"),
              const SizedBox(height: 24),
              const FormSectionTitle(title: "Sampah Basah", color: Colors.orange),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: "Total Berat",
                controller: beratBasahController,
                spacing: 160,
                suffixText: "Kg",
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const UploadImagePlaceholder(title: "Foto Sampah Sebelum Diangkat"),
              const SizedBox(height: 20),
              const UploadImagePlaceholder(title: "Foto Sampah Sesudah Diangkat"),
              const SizedBox(height: 24),
              Text(
                "Catatan",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: catatanController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tambahkan Catatan',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: true,
                  ),
                  style: const TextStyle(fontSize: 13),
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuccesScreen()),
                      );
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
