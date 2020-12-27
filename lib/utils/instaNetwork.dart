import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class InstaNetwork {
  static dynamic getInstaData() async {
    try {
      final String url = 'https://www.instagram.com/callofdutymobile/?__a=1';
      final response = await http.get(url).timeout(Duration(seconds: 7));
      return jsonDecode(response.body);
    } on TimeoutException catch (e) {
      return 'Timeout';
    } on SocketException catch (e) {
      return 'Socket';
    } on FormatException catch (e) {
      return 'JsonFormat';
    }
  }
}
