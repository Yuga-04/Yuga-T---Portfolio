import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // Replace these with your actual EmailJS credentials
  static const String serviceId = "service_fzp84fl";
  static const String templateId = "template_dffew28";
  static const String publicKey = "skVesSd34-TuBJmCG";

  static Future<bool> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": publicKey,
          "template_params": {
            "name": name, // This will fill {{name}}
            "title": "Message from Portfolio", // This will fill {{title}}
            "email": email, // This will fill {{email}}
            "from_email": email, // Alternative variable name
            "reply_to": email, // For reply-to functionality
            "message": message, // This will fill {{message}}
            "user_email": email, // Another alternative
          },
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      // EmailJS returns 200 for successful sends
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      print("ERROR: $e");
      return false;
    }
  }
}
