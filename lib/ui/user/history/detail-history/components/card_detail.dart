import 'package:bersihku/controller/detail_history_controller.dart';
import 'package:bersihku/controller/profile_user_controller.dart';
import 'package:bersihku/ui/user/history/detail-history/components/card_image.dart';
import 'package:bersihku/ui/user/history/detail-history/components/notes.dart';
import 'package:bersihku/ui/user/history/detail-history/components/total_wight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';

class CardDetailHistory extends StatelessWidget {
  final String documentId;
  const CardDetailHistory({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryDetailController>(tag: documentId); // ambil berdasarkan tag
    final profileController = Get.find<ProfileUserController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final data = controller.detail.value;
      if (data == null) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profil User
              Row(
                children: [
                  Obx(() {
                    final imgUrl = profileController.profileImageUrl.value;
                    return (imgUrl == null || imgUrl.isEmpty)
                        ? Image.asset(
                            "assets/images/profile-person-history.png",
                            width: MediaQuery.of(context).size.width * 0.12,
                            fit: BoxFit.contain,
                          )
                        : CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.06,
                            backgroundImage: NetworkImage(imgUrl),
                          );
                  }),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                      ),
                      Text(
                        data.platNomor,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Alamat & Jadwal
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.lokasi,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    data.alamat,
                    style: const TextStyle(fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.tanggal, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      Text(data.waktu, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CardImage(
                    imagesBasah: data.imagesBasah,
                    imagesKering: data.imagesKering,
                  ),
                  const SizedBox(height: 25),
                  TotalWight(total: data.beratKeseluruhan),
                  const SizedBox(height: 22),
                  NotesDetailHistory(note: data.catatan),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}