import 'package:codm/views/twitterViews/tweet_heading_card.dart';
import 'package:flutter/material.dart';

class TweetListView extends StatefulWidget {
  final List pinnedTweetObjects;
  final List tweetObjects;
  TweetListView({this.tweetObjects, this.pinnedTweetObjects});

  @override
  _TweetListViewState createState() => _TweetListViewState();
}

class _TweetListViewState extends State<TweetListView> {
  List<Widget> objects;

  @override
  void initState() {
    super.initState();
    objects = (widget.pinnedTweetObjects.isNotEmpty &&
            widget.pinnedTweetObjects != null
        ? widget.pinnedTweetObjects
            .map((e) => TweetHeadingCardView(
                  tweetObjects: e,
                  pinnedHead: Icon(
                    Icons.push_pin_sharp,
                    color: Colors.blue,
                  ),
                ))
            .toList()
        : [])
      ..addAll(widget.tweetObjects
          .map((e) => TweetHeadingCardView(tweetObjects: e))
          .toList());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, item) => objects[item],
      separatorBuilder: (context, item) => SizedBox(
        height: 20.0,
      ),
      itemCount: objects.length,
    );
  }
}
