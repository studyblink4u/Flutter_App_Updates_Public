import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InstaHeadingCardView extends StatefulWidget {
  final instaObject;
  final key;
  InstaHeadingCardView({this.instaObject, this.key});

  @override
  _InstaHeadingCardViewState createState() => _InstaHeadingCardViewState();
}

class _InstaHeadingCardViewState extends State<InstaHeadingCardView> {
  var image;

  @override
  void initState() {
    super.initState();
    image = Image.network(widget.instaObject.getThumnail());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15 >= 75.0
          ? (MediaQuery.of(context).size.height * 0.70) - 55.0
          : MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.instaObject.getPostDay(),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    gradient: LinearGradient(
                        colors: [
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
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: image)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.instaObject.getUpdateName(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
