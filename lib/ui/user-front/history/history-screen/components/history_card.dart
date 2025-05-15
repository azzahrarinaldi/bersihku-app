import 'package:bersihku/const.dart';
import 'package:bersihku/controller/profile_user_controller.dart';
import 'package:bersihku/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'history_menu.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel history;

 const HistoryCard({super.key, required this.history});
  
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileUserController());
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(() {
                    final imgUrl = controller.profileImageUrl.value;
                    return (imgUrl!.isEmpty)
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
                        history.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        history.vehicle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              HistoryMenu(documentId: history.documentId),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            history.place,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            history.address,
            style: const TextStyle(fontSize: 11),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                history.date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                history.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                history.type,
                style: const TextStyle(
                  fontSize: 13,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${history.weight} Kg",
                style: const TextStyle(
                  fontSize: 13,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
