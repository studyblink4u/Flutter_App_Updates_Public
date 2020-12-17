import 'package:codm/konstants.dart';
import 'package:codm/models/tweet/tweetObject.dart';
import 'package:flutter/material.dart';

class TweetObjectList {
  final jsonResponse;
  TweetObjectList({this.jsonResponse});

  List<TweetObject> getObjectList() {
    List<TweetObject> tweetObjectList = [];
    final dataList = jsonResponse['data'];

    if (dataList is List) {
      for (var child in dataList) {
        addObject(child, tweetObjectList);
      }
    } else {
      addObject(dataList, tweetObjectList);
    }
    return tweetObjectList;
  }

  void addObject(child, List<TweetObject> tweetObjectList) {
    var url;
    var text = textProcess(text: child['text']);
    var lang = child['lang'];
    var ref = child['referenced_tweets'];
    var mediaUrl;
    var mediaKey;
    try {
      mediaKey = child['attachments']['media_keys'][0];
    } catch (error) {
      mediaKey = null;
    }
    if (text != null && lang != null && lang == 'en' && ref == null) {
      url = extractUrl(text: child['text']);

      if (mediaKey != null) {
        for (var anotherChild in jsonResponse['includes']['media']) {
          if (anotherChild['media_key'] == mediaKey) {
            switch (anotherChild['type']) {
              case 'video':
                mediaUrl = anotherChild['preview_image_url'];
                break;
              case 'photo':
                mediaUrl = anotherChild['url'];
                break;
              default:
                mediaUrl = anotherChild['url'];
            }
          }
        }
      }
      tweetObjectList.add(TweetObject(
          updateName: text, language: lang, mediaUrl: mediaUrl, tweetUrl: url));
    }
  }
}

String textProcess({String text}) {
  return text.replaceAll('amp;', '').replaceAll(kRegexUrl, '');
}

String extractUrl({String text}) {
  return kRegexUrl.stringMatch(text);
}
