import 'package:codm/models/reddit/redditObject.dart';

class RedditObjectList {
  final jsonResponse;
  RedditObjectList({this.jsonResponse});

  List<RedditObject> getObjectList() {
    final htmlBody = jsonResponse['data']['children'];
    List<RedditObject> redditObjects = [];
    for (var child in htmlBody) {
      var heading = child['data']['title'];
      var thumbnail = child['data']['thumbnail'];
      double unixTime = child['data']['created_utc'];
      var htmlText = child['data']['selftext_html'];
      redditObjects.add(RedditObject(
          thumnail: thumbnail,
          updateName: heading,
          unixTime: unixTime.toInt(),
          htmlText: htmlText));
    }
    return redditObjects;
  }
}
