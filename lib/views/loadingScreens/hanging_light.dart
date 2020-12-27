import 'package:codm/views/animations/hanging_light_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codm/konstants.dart';

class HangingLight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HangingLightAnimation(),
        Center(
          child: Consumer<ChangeModeProvider>(builder: (context, value, child) {
            return Text(
              'Loading...',
              style: TextStyle(
                fontSize: 50.0,
                color: value.getModeColor,
              ),
            );
          }),
        ),
      ],
      fit: StackFit.passthrough,
      overflow: Overflow.clip,
    );
  }
}
