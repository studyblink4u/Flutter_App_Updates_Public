import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RedditHeadingCardView extends StatefulWidget {
  final redditObject;
  RedditHeadingCardView({this.redditObject});
  @override
  _RedditHeadingCardViewState createState() => _RedditHeadingCardViewState();
}

class _RedditHeadingCardViewState extends State<RedditHeadingCardView> {
  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = Image.network(widget.redditObject.getThumnail());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: image,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.redditObject.getUpdateName(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.redditObject.getPostDay(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
