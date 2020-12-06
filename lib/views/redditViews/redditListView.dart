import 'package:codm/views/redditViews/redditHeadingCardView.dart';
import 'package:flutter/material.dart';

class RedditListView extends StatelessWidget {
  final List redditObjects;
  RedditListView({this.redditObjects});

  @override
  Widget build(BuildContext context) {
    List<Widget> objects = redditObjects
        .map((e) => RedditHeadingCardView(redditObject: e))
        .toList();
    return ListWheelScrollView(
      children: objects,
      itemExtent: 100.0,
      offAxisFraction: 1.5,
    );
  }
}
