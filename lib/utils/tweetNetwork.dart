import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:codm/tokens.dart';
import 'package:http/http.dart' as http;

class TweetNetwork {
  static dynamic getTweetData() async {
    try {
      final String url =
          'https://api.twitter.com/2/tweets/search/recent?query=from:PlayCODMobile&max_results=100&user.fields=profile_image_url&tweet.fields=attachments,lang,referenced_tweets&expansions=attachments.media_keys,author_id&media.fields=media_key,preview_image_url,type,url';
      final response = await http.get(url, headers: {
        'authorization': 'Bearer $twitterKey',
      }).timeout(Duration(seconds: 7));
      return jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    } on TimeoutException catch (e) {
      return 'Timeout';
    } on SocketException catch (e) {
      return 'Socket';
    } on FormatException catch (e) {
      return 'JsonDecode';
    }
  }
}

class PinnedTweet {
  static dynamic getPinnedTweet() async {
    try {
      final String url =
          'https://api.twitter.com/2/users/by/username/PlayCODMobile?user.fields=pinned_tweet_id';
      final response = await http.get(url, headers: {
        'authorization': 'Bearer $twitterKey',
      });
      String id = jsonDecode(Utf8Decoder().convert(response.bodyBytes))['data']
          ['pinned_tweet_id'];

      final String sUrl =
          'https://api.twitter.com/2/tweets/$id?user.fields=created_at&tweet.fields=attachments,lang,referenced_tweets,text&expansions=attachments.media_keys&media.fields=media_key,preview_image_url,type,url';
      final sResponse = await http.get(sUrl, headers: {
        'authorization': 'Bearer $twitterKey',
      });
      return jsonDecode(Utf8Decoder().convert(sResponse.bodyBytes));
    } catch (e) {
      return;
    }
  }
}
