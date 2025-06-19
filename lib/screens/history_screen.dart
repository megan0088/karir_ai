

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ai_controller.dart';


class HistoryScreen extends StatelessWidget {
  final controller = Get.find<AIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Konsultasi'), centerTitle: true),
      body: Obx(
        () => controller.history.isEmpty
            ? Center(child: Text('Belum ada riwayat.'))
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  final item = controller.history[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text('🎯 Tujuan: ${item['tujuan']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text('❤️ Minat: ${item['minat']}'),
                          Text('🛠️ Skill: ${item['skill']}'),
                          SizedBox(height: 8),
                          Text(
                            item['hasil'] ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
