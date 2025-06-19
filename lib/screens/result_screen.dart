
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/ai_controller.dart';

class ResultScreen extends StatelessWidget {
  final controller = Get.find<AIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hasil Konsultasi'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Lottie.asset(
              'assets/lottie/success.json',
              width: 200,
              height: 200,
              repeat: false,
            ),
            SizedBox(height: 20),
            Text(
              'Rekomendasi Karier untukmu:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Obx(
                      () => Text(
                        controller.result.value,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.reset();
                Get.back(); 
              },
              icon: Icon(Icons.refresh),
              label: Text('Tanya Lagi'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
