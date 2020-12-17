import 'dart:convert';
import 'package:http/http.dart' as http;

class InstaNetwork {
  static dynamic getInstaData() async {
    final String url = 'https://www.instagram.com/callofdutymobile/?__a=1';
    final response = await http.get(url).then((value) {
      return value;
    });
    return jsonDecode(response.body);
  }
}
