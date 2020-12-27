import 'package:codm/views/animations/moving_dot_animation.dart';
import 'package:codm/konstants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurvedNavigationBarClass extends StatefulWidget {
  final double height;

  CurvedNavigationBarClass({this.height});
  @override
  _CurvedNavigationBarClassState createState() =>
      _CurvedNavigationBarClassState();
}

class _CurvedNavigationBarClassState extends State<CurvedNavigationBarClass> {
  List<Widget> bottomDots;
  @override
  void initState() {
    super.initState();
    bottomDots = MovingDot().getDots(dotCount: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChangeModeProvider, FetchData>(
      builder: (context, changeModeProviderValue, fetchDataValue, child) {
        return CurvedNavigationBar(
          index: fetchDataValue.getIndex,
          dots: changeModeProviderValue.getMode ? bottomDots : [],
          color: changeModeProviderValue.getModeColor,
          height: widget.height,
          items: [
            Text(
              'reddit',
              style: TextStyle(
                  color: changeModeProviderValue.getModeContrastColor),
            ),
            Text(
              'insta',
              style: TextStyle(
                  color: changeModeProviderValue.getModeContrastColor),
            ),
            Text(
              'tweet',
              style: TextStyle(
                  color: changeModeProviderValue.getModeContrastColor),
            )
          ],
          onTap: (index) {
            fetchDataValue.setLoadingStatus = true;
            fetchDataValue.setCurrentWidgetList = index;
          },
        );
      },
    );
  }
}
