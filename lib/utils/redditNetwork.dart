import 'dart:convert';
import 'package:http/http.dart' as http;

class RedditNetwork {
  static dynamic getRedditData() async {
    final String url =
        'https://www.reddit.com/user/COD_Mobile_Official/submitted/.json?sort=new&raw_json=1';
    final response = await http.get(url).then((value) {
      return value;
    });

    return jsonDecode(response.body);
  }
}
