import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  Future<String> sendMessage(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'ft:gpt-3.5-turbo-0125:personal:autoaid-diagnostic:9cRLIMnx',
      'messages': [
        {'role': 'user', 'content': message}
      ],
      'max_tokens': 1000,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final responseMessage = jsonResponse['choices'][0]['message']['content'];
        return responseMessage;
      } else {
        print('Failed to load response: ${response.statusCode}');
        throw Exception('Failed to load response');
      }
    } catch (e) {
      print('Failed to send message: $e');
      throw Exception('Failed to send message to OpenAI');
    }
  }
}
