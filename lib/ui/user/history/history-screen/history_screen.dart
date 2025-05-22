import 'package:bersihku/controller/history_controller.dart';
import 'package:bersihku/ui/user/history/history-screen/components/history_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF4EBAE5),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue-pettern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            final histories = controller.historyList;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: 15,
                  ),
                  child: const Text(
                    "Riwayat Pengangkutan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (histories.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: HistoryCard(history: histories.first),
                  ),
                ] else
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Belum ada data laporan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: histories.length <= 1
                        ? const Center(child: Text('Belum ada riwayat lainnya'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: histories.length - 1,
                            itemBuilder: (context, index) {
                              return HistoryCard(history: histories[index + 1]);
                            },
                          ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}