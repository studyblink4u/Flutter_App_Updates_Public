import 'package:cached_network_image/cached_network_image.dart';
import 'package:codm/main.dart';
import 'package:codm/models/tweet/tweetObject.dart';
import 'package:flutter/material.dart';

class TweetHeadingCardView extends StatefulWidget {
  final TweetObject tweetObjects;
  TweetHeadingCardView({this.tweetObjects});

  @override
  _TweetHeadingCardViewState createState() => _TweetHeadingCardViewState();
}

class _TweetHeadingCardViewState extends State<TweetHeadingCardView> {
  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = Image.network(widget.tweetObjects.getMediaUrl());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebViewPage(
                  url: widget.tweetObjects.getTweetUrl(),
                )));
      },
      child: Container(
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: LinearGradient(colors: [
              Colors.pink,
              Colors.pinkAccent,
              Colors.purpleAccent,
              Colors.purple,
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurpleAccent,
              Colors.purple,
              Colors.purpleAccent,
              Colors.pinkAccent,
              Colors.pink,
              Colors.pinkAccent,
              Colors.purpleAccent,
              Colors.purple,
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurpleAccent,
              Colors.purple,
              Colors.purpleAccent,
              Colors.pinkAccent,
              Colors.pink,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.tweetObjects.getUpdateName(),
                softWrap: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: image),
            ],
          ),
        ),
      ),
    );
  }
}

// class TweetView extends StatefulWidget {
//   final json;
//   TweetView({this.json});
//   @override
//   _TweetViewState createState() => _TweetViewState();
// }

// class _TweetViewState extends State<TweetView> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SingleChildScrollView(child: Text(widget.json.toString())),
//     );
//   }
// }
