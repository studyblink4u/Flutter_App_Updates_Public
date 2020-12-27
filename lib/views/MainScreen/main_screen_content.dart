import 'package:codm/konstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'curved_navigation_bar_local.dart';

class MainScreenContent extends StatelessWidget {
  final double height;
  final double width;

  MainScreenContent({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            width: width * 0.90,
            child: Consumer<FetchData>(builder: (context, value, child) {
              return value.getLoadingStatus
                  ? Container()
                  : Column(
                      children: [
                        SizedBox(height: height * 0.12),
                        Expanded(
                          child: Center(
                            child: value.getCurrentWidgetList,
                          ),
                        )
                      ],
                    );
            }),
          ),
        ),
        Container(
          height: 5.0,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: kCurvedNavigationBarTop,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
        ),
        Consumer<FetchData>(
          builder: (context, value, child) {
            return value.getLoadingStatus
                ? Container(
                    color: Colors.transparent,
                    height: 0.1,
                  )
                : CurvedNavigationBarClass(
                    height: kGetCurvedNavigationBarHeight(height),
                  );
          },
        ),
        kFullWidthContainer,
      ],
    );
  }
}
