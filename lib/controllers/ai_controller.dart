import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/ai_service.dart';

class AIController extends GetxController {
  var isLoading = false.obs;
  var result = ''.obs;

  final interestController = TextEditingController();
  final skillsController = TextEditingController();
  final goalController = TextEditingController();

  var history = <Map<String, String>>[].obs;

  Future<void> getRecommendation() async {
    final interest = interestController.text;
    final skills = skillsController.text;
    final goal = goalController.text;

    isLoading.value = true;
    try {
      final response = await AIService.getCareerRecommendation(
        interest: interest,
        skills: skills,
        goal: goal,
      );
      result.value = response;
    } catch (e) {
      result.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    if (result.value.isNotEmpty) {
      history.add({
        'minat': interestController.text,
        'skill': skillsController.text,
        'tujuan': goalController.text,
        'hasil': result.value,
      });
    }

    interestController.clear();
    skillsController.clear();
    goalController.clear();
    result.value = '';
  }
}
