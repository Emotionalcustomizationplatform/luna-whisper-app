import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ 改成你自己的服务器地址
  static const String baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> submitBooking({
    required String name,
    required String email,
    required String whatsapp,
    required String sessionPlan,
    required String preferredTime,
    String? specialRequest,
    required String paymentMethod,
    String? orderId,
    int? priceUsd,
    int? priceCny,
  }) async {
    final url = Uri.parse('$baseUrl/api/submit');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'whatsapp': whatsapp,
        'session_plan': sessionPlan,
        'preferred_time': preferredTime,
        'special_request': specialRequest ?? '',
        'payment_method': paymentMethod,
        'order_id': orderId ?? '',
        'session_price_usd': priceUsd ?? 29,
        'session_price_cny': priceCny ?? 203,
        'website': '',
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to submit booking');
    }
  }
}
