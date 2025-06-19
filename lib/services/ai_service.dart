// 📁 lib/services/ai_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const _apiKey =
      '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';
  static const _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';

  static Future<String> getCareerRecommendation({
    required String interest,
    required String skills,
    required String goal,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer':
              'https://yourapp.com', // ganti dengan domain kamu atau localhost
          'X-Title': 'Tanya AI Konsultan Karier',
        },
        body: jsonEncode({
          "model": "openai/gpt-3.5-turbo", // atau bisa ganti model lain
          "messages": [
            {
              "role": "system",
              "content":
                  "Kamu adalah konsultan karier profesional yang memberikan saran berdasarkan minat, skill, dan tujuan hidup pengguna.",
            },
            {
              "role": "user",
              "content":
                  "Minat saya: $interest\nSkill saya: $skills\nTujuan saya: $goal\nBerikan saran karier yang cocok untuk saya dan langkah-langkah awalnya.",
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception("Gagal mendapatkan respon dari AI: ${response.body}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
