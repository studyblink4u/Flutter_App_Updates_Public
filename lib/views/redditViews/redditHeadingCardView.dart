import 'package:flutter/material.dart';

class RedditHeadingCardView extends StatelessWidget {
  final redditObject;
  RedditHeadingCardView({this.redditObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.network(
              redditObject.getThumnail(),
              height: 100.0,
              width: 100.0,
              fit: BoxFit.fitWidth,
            ),
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
                  redditObject.getUpdateName(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    redditObject.getPostDay(),
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
