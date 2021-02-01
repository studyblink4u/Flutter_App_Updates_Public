import 'package:cached_network_image/cached_network_image.dart';
import 'package:codm/konstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstaHeadingCardView extends StatefulWidget {
  final instaObject;
  InstaHeadingCardView({this.instaObject});

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
    precacheImage(image.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child:
                Consumer<ChangeModeProvider>(builder: (context, value, child) {
              return Text(
                widget.instaObject.getPostDay(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: value.getMode ? Colors.pink : Colors.purple,
                    fontWeight: FontWeight.bold),
              );
            }),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                      colors: kLongGradient,
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
    );
  }
}
