import 'package:codm/views/instaViews/instaHeadingCard.dart';
import 'package:flutter/material.dart';

class InstaListView extends StatelessWidget {
  final List instaObjects;
  InstaListView({this.instaObjects});

  @override
  Widget build(BuildContext context) {
    List<Widget> objects =
        instaObjects.map((e) => InstaHeadingCardView(instaObject: e)).toList();
    return animatedSwitcher(objects: objects);
  }
}

// class simpleHorizontalRow extends StatelessWidget {
//   const simpleHorizontalRow({
//     Key key,
//     @required this.objects,
//   }) : super(key: key);
//
//   final List<Widget> objects;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         scrollDirection: Axis.horizontal, child: Row(children: objects));
//   }
// }

class animatedSwitcher extends StatefulWidget {
  final List<Widget> objects;
  animatedSwitcher({this.objects});

  @override
  _animatedSwitcherState createState() => _animatedSwitcherState();
}

class _animatedSwitcherState extends State<animatedSwitcher> {
  var currentItem;
  var previousItem;
  var nextItem;
  List<Widget> objects;
  @override
  void initState() {
    super.initState();
    objects = widget.objects;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return objects[index];
        },
        itemCount: objects.length,
      ),
    );
  }
}
