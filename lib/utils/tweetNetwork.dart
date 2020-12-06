import 'dart:convert';
import 'package:http/http.dart' as http;

class TweetNetwork {
  static dynamic getTweetData() async {
    final String url =
        'https://api.twitter.com/2/tweets/search/recent?query=from:PlayCODMobile&max_results=100&user.fields=created_at&tweet.fields=attachments,lang,referenced_tweets&expansions=attachments.media_keys&media.fields=media_key,preview_image_url,type,url';
    final response = await http.get(url, headers: {
      'authorization':
          'Bearer AAAAAAAAAAAAAAAAAAAAAFJmKAEAAAAA2f2SWbfdKhbEO4%2B6KV6Vs7lns%2Bc%3D9VSIjSnZR4Vpow4rrf2fjb2W1i0cW61RhsVdfboxXrMQ6c33zs',
    }).then((value) {
      return value;
    });
    return jsonDecode(Utf8Decoder().convert(response.bodyBytes));
  }
}

class PinnedTweet {
  static dynamic getPinnedTweet() async {
    final String url =
        'https://api.twitter.com/2/users/by/username/PlayCODMobile?user.fields=pinned_tweet_id';
    final response = await http.get(url, headers: {
      'authorization':
          'Bearer AAAAAAAAAAAAAAAAAAAAAFJmKAEAAAAA2f2SWbfdKhbEO4%2B6KV6Vs7lns%2Bc%3D9VSIjSnZR4Vpow4rrf2fjb2W1i0cW61RhsVdfboxXrMQ6c33zs',
    }).then((value) {
      return value;
    });
    String id = jsonDecode(Utf8Decoder().convert(response.bodyBytes))['data']
        ['pinned_tweet_id'];

    final String sUrl =
        'https://api.twitter.com/2/tweets/$id?user.fields=created_at&tweet.fields=attachments,lang,referenced_tweets,text&expansions=attachments.media_keys&media.fields=media_key,preview_image_url,type,url';
    final sResponse = await http.get(sUrl, headers: {
      'authorization':
          'Bearer AAAAAAAAAAAAAAAAAAAAAFJmKAEAAAAA2f2SWbfdKhbEO4%2B6KV6Vs7lns%2Bc%3D9VSIjSnZR4Vpow4rrf2fjb2W1i0cW61RhsVdfboxXrMQ6c33zs',
    }).then((value) {
      return value;
    });
    return jsonDecode(Utf8Decoder().convert(sResponse.bodyBytes));
  }
}
