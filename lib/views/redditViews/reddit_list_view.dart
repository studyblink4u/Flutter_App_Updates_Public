import 'package:codm/models/reddit/redditObject.dart';
import 'package:codm/views/redditViews/reddit_heading_card_view.dart';
import 'package:codm/views/redditViews/reddit_view.dart';
import 'package:flutter/material.dart';

class RedditListView extends StatefulWidget {
  final List<RedditObject> redditObjects;
  RedditListView({this.redditObjects});
  @override
  _RedditListViewState createState() => _RedditListViewState();
}

class _RedditListViewState extends State<RedditListView> {
  var selectedItem;
  List<Widget> objects;

  @override
  void initState() {
    super.initState();
    selectedItem = 0;
    objects = widget.redditObjects
        .map((e) => RedditHeadingCardView(redditObject: e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListWheelScrollView(
        physics: FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.7,
        squeeze: 0.9,
        children: objects,
        itemExtent: 100.0,
        offAxisFraction: 0.5,
        onSelectedItemChanged: (index) => selectedItem = index,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HtmlViewPage(
                  body: widget.redditObjects[selectedItem].getHtmlText(),
                )));
      },
    );
  }
}
