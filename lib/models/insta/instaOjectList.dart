import 'package:codm/models/insta/instaObject.dart';

class InstaObjectList {
  final jsonResponse;
  InstaObjectList({this.jsonResponse});

  List<InstaObject> getObjectList() {
    final htmlBody = jsonResponse['graphql']['user']
        ['edge_owner_to_timeline_media']['edges'];
    List<InstaObject> instaObjectList = [];

    for (var child in htmlBody) {
      var heading;
      try {
        heading =
            child['node']['edge_media_to_caption']['edges'][0]['node']['text'];
      } catch (error) {
        heading = '';
      }
      var thumbnail = child['node']['display_url'];
      int unixTime = child['node']['taken_at_timestamp'];
      var mediaUrl;
      if (child['node']['is_video']) {
        mediaUrl = child['node']['selftext_html'];
      } else {
        mediaUrl = null;
      }
      instaObjectList.add(InstaObject(
          thumnail: thumbnail,
          updateName: heading,
          unixTime: unixTime,
          mediaUrl: mediaUrl));
    }
    return instaObjectList;
  }
}
