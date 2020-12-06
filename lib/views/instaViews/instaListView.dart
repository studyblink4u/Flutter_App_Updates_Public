import 'package:codm/views/instaViews/instaHeadingCard.dart';
import 'package:flutter/material.dart';

class InstaListView extends StatelessWidget {
  final List instaObjects;
  InstaListView({this.instaObjects});

  @override
  Widget build(BuildContext context) {
    List<Widget> objects =
        instaObjects.map((e) => InstaHeadingCardView(instaObject: e)).toList();
    return Column(children: objects);
  }
}
