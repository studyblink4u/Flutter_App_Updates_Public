import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RedditNetwork {
  static dynamic getRedditData() async {
    try {
      final String url =
          'https://www.reddit.com/user/COD_Mobile_Official/submitted/.json?sort=new&raw_json=1';
      final response = await http.get(url).timeout(Duration(seconds: 10));
      return jsonDecode(response.body);
    } on TimeoutException {
      return 'Timeout';
    } on SocketException {
      return 'Socket';
    } on FormatException {
      return 'JsonFormat';
    }
  }
}
