import 'package:codm/views/instaViews/instaHeadingCard.dart';
import 'package:flutter/material.dart';

class InstaListView extends StatelessWidget {
  final List instaObjects;
  InstaListView({this.instaObjects});

  @override
  Widget build(BuildContext context) {
    List<Widget> objects = instaObjects
        .map((e) => InstaHeadingCardView(
            instaObject: e, key: ValueKey(instaObjects.indexOf(e))))
        .toList();
    return animatedSwitcher(objects: objects);
  }
}

class simpleHorizontalRow extends StatelessWidget {
  const simpleHorizontalRow({
    Key key,
    @required this.objects,
  }) : super(key: key);

  final List<Widget> objects;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: objects));
  }
}

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
  @override
  void initState() {
    super.initState();
    print(widget.objects);
    if (widget.objects.length > 2) {
      currentItem = widget.objects[0];
      nextItem = widget.objects[1];
    } else if (widget.objects.length > 1) {
      currentItem = widget.objects[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity < 0) {
          setState(() {
            if (nextItem != null) {
              previousItem = currentItem;
              currentItem = nextItem;
              if (widget.objects.indexOf(nextItem) <
                  widget.objects.length - 1) {
                nextItem = widget.objects[widget.objects.indexOf(nextItem) + 1];
              } else
                nextItem = null;
            }
          });
        } else if (details.primaryVelocity > 0) {
          setState(() {
            if (previousItem != null) {
              nextItem = currentItem;
              currentItem = previousItem;
              if (widget.objects.indexOf(previousItem) > 0) {
                previousItem =
                    widget.objects[widget.objects.indexOf(previousItem) - 1];
              } else
                previousItem = null;
            }
          });
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation animation) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: currentItem,
      ),
    );
  }
}
