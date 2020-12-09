import 'package:codm/views/redditViews/redditHeadingCardView.dart';
import 'package:flutter/material.dart';

class RedditListView extends StatefulWidget {
  final List redditObjects;
  RedditListView({this.redditObjects});
  @override
  _RedditListViewState createState() => _RedditListViewState();
}

class _RedditListViewState extends State<RedditListView> {
  @override
  @override
  Widget build(BuildContext context) {
    List<Widget> objects = widget.redditObjects
        .map((e) => RedditHeadingCardView(redditObject: e))
        .toList();
    return ListWheelScrollView(
      children: objects,
      itemExtent: 100.0,
      offAxisFraction: -0.5,
    );
  }
}
