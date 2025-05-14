import 'package:bersihku/ui/admin-front/notification-screen/components/card_supir.dart';
import 'package:bersihku/ui/admin-front/notification-screen/components/header_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bersihku/const.dart';
import 'package:bersihku/controllers/notification_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DetailNotifikasiAdmin extends StatelessWidget {
  DetailNotifikasiAdmin({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pattern_oren.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                HeaderNotifikasi(size: size),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.notifications_active, color: secondaryColor),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifikasi Baru",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Obx(() {
                                return Text(
                                  "Ada ${controller.notificationList.length} pengangkutan terdekat hari ini.",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [
                                Color(0xFF9AE2FF),
                                Color(0xFFF9E071),
                                Color(0xFFF29753)
                              ],
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      if (controller.notificationList.isEmpty) {
                        return const Center(
                          child: Text("Tidak ada notifikasi"),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(size.width * 0.05),
                        itemCount: controller.notificationList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CardSupir(
                              data: controller.notificationList[index],
                              size: size,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
