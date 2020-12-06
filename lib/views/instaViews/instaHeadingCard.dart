import 'package:flutter/material.dart';

class InstaHeadingCardView extends StatelessWidget {
  final instaObject;
  InstaHeadingCardView({this.instaObject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.network(
              instaObject.getThumnail(),
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
                  instaObject.getUpdateName(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    instaObject.getPostDay(),
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
