import 'package:codm/views/twitterViews/tweetHeadingCard.dart';
import 'package:flutter/material.dart';

class TweetListView extends StatelessWidget {
  final List pinnedTweetObjects;
  final List tweetObjects;
  TweetListView({this.tweetObjects, this.pinnedTweetObjects});

  @override
  Widget build(BuildContext context) {
    List<Widget> objects = (pinnedTweetObjects.isNotEmpty
        ? pinnedTweetObjects
            .map((e) => TweetHeadingCardView(
                  tweetObjects: e,
                ))
            .toList()
        : [])
      ..addAll(tweetObjects
          .map((e) => TweetHeadingCardView(tweetObjects: e))
          .toList());

    print(objects);
    return Column(children: objects);
  }
}
