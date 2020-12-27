import 'package:codm/models/reddit/redditObject.dart';

class RedditObjectList {
  final jsonResponse;
  RedditObjectList({this.jsonResponse});

  List<RedditObject> redditObjects = [];

  List<RedditObject> getObjectList() {
    final htmlBody = jsonResponse['data']['children'];
    for (var child in htmlBody) {
      String heading = child['data']['title'] ?? 'Codm - Update';
      String thumbnail = child['data']['thumbnail'] ?? 'self';
      double unixTime = child['data']['created_utc'] ?? 0.0;
      String htmlText =
          child['data']['selftext_html'] ?? 'Sorry!!!  Content broken';
      redditObjects.add(RedditObject(
          thumnail: thumbnail,
          updateName: heading,
          unixTime: unixTime.toInt(),
          htmlText: htmlText));
    }
    return redditObjects;
  }
}
