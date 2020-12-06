import 'package:cached_network_image/cached_network_image.dart';
import 'package:codm/main.dart';
import 'package:codm/models/tweet/tweetObject.dart';
import 'package:flutter/material.dart';

class TweetHeadingCardView extends StatelessWidget {
  final TweetObject tweetObjects;
  TweetHeadingCardView({this.tweetObjects});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebViewPage(
                  url: tweetObjects.getTweetUrl(),
                )));
      },
      child: Container(
        color: Colors.greenAccent,
        padding: EdgeInsets.only(bottom: 10.0),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Icon(Icons.ac_unit),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tweetObjects.getUpdateName(),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      tweetObjects.getLanguage(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CachedNetworkImage(imageUrl: tweetObjects.getMediaUrl()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TweetView extends StatefulWidget {
  final json;
  TweetView({this.json});
  @override
  _TweetViewState createState() => _TweetViewState();
}

class _TweetViewState extends State<TweetView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(child: Text(widget.json.toString())),
    );
  }
}
