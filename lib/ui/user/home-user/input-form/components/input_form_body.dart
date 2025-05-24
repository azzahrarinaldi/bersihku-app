// ignore_for_file: avoid_print
import 'package:bersihku/const.dart';
import 'package:bersihku/controller/form_controller.dart';
import 'package:bersihku/ui/user/home-user/input-form/components/form_field_row.dart';
import 'package:bersihku/ui/user/home-user/input-form/components/form_section.dart';
import 'package:bersihku/ui/user/home-user/input-form/components/location_dropdown.dart';
import 'package:bersihku/ui/user/home-user/input-form/components/submit-image/image_placeholder.dart';
import 'package:flutter/material.dart';

class InputFormBody extends StatefulWidget {
  const InputFormBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputFormBodyState createState() => _InputFormBodyState();
}

class _InputFormBodyState extends State<InputFormBody> {
  final controller = InputFormController();

  @override
  void initState() {
    super.initState();
    controller.initListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 15,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Lokasi Drop Point',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              LocationDropdown(
                onChanged: (lokasi, alamat) {
                  setState(() {
                    controller.selectedLocation = lokasi;
                    controller.selectedAddress = alamat;
                  });
                },
                validator: (v) => v == null ? 'Lokasi wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: 'Nomor Plat Truk',
                controller: controller.platController,
                spacing: 93,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
                isPlate: true,
              ),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: 'Total Berat Keseluruhan',
                controller: controller.beratKeseluruhanController,
                spacing: 40,
                suffixText: 'Kg',
                readOnly: true,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 24),
              const FormSectionTitle(
                  title: 'Sampah Kering', color: secondaryColor),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: 'Total Berat Kering',
                controller: controller.beratKeringController,
                spacing: 80,
                suffixText: 'Kg',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 16),
              UploadImagePlaceholder(
                title: 'Foto Kering Sebelum Diangkut',
                onImagesChanged: controller.addImagesKering,
              ),
              const SizedBox(height: 20),
              UploadImagePlaceholder(
                title: 'Foto Kering Sesudah Diangkut',
                onImagesChanged: controller.addImagesKering,
              ),
              const SizedBox(height: 24),
              const FormSectionTitle(
                  title: 'Sampah Basah', color: Colors.orange),
              const SizedBox(height: 16),
              FieldWithLabel(
                label: 'Total Berat Basah',
                controller: controller.beratBasahController,
                spacing: 80,
                suffixText: 'Kg',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 16),
              UploadImagePlaceholder(
                title: 'Foto Basah Sebelum Diangkut',
                onImagesChanged: controller.addImagesBasah,
              ),
              const SizedBox(height: 20),
              UploadImagePlaceholder(
                title: 'Foto Basah Sesudah Diangkut',
                onImagesChanged: controller.addImagesBasah,
              ),
              const SizedBox(height: 24),
              const Text(
                'Catatan',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                height: 150,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: controller.catatanController,
                  onFieldSubmitted: (value) {
                    print("Submit: $value");
                  },
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tambahkan Catatan',
                    hintStyle: TextStyle(fontSize: 13),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () => controller.submitForm(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  child: controller.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
