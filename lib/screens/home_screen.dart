import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/ai_controller.dart';
import 'result_screen.dart';
import 'history_screen.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final controller = Get.find<AIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎓 Tanya AI - Konsultan Karier'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () =>
                Get.to(() => HistoryScreen()), // Navigasi ke histori
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Lottie.asset('assets/lottie/consult.json', height: 200),
            const SizedBox(height: 16),
            Text(
              'Dapatkan saran karier & roadmap belajar dari AI ✨',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildInputField('Minat kamu', controller.interestController),
            const SizedBox(height: 16),
            _buildInputField('Skill kamu', controller.skillsController),
            const SizedBox(height: 16),
            _buildInputField('Tujuan hidup kamu', controller.goalController),
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () async {
                        await controller.getRecommendation();
                        if (controller.result.value.isNotEmpty) {
                          Get.to(() => ResultScreen());
                        }
                      },
                      icon: const Icon(Icons.smart_toy),
                      label: const Text('Tanya AI'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.edit),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
