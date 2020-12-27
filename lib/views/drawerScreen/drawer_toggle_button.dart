import 'package:codm/konstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerToggleButton extends StatefulWidget {
  @override
  _DrawerToggleButtonState createState() => _DrawerToggleButtonState();
}

class _DrawerToggleButtonState extends State<DrawerToggleButton> {
  List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeModeProvider>(builder: (context, value, child) {
      return ToggleButtons(
        borderColor: value.kModeContrastColor,
        selectedBorderColor: value.kModeContrastColor,
        fillColor: value.getMode ? Colors.pink[400] : Colors.purple[400],
        borderWidth: 2,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.nights_stay_outlined,
              color: value.getMode ? Colors.white : Colors.purple,
              size: value.getMode ? 26.0 : 14.0,
            ),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.wb_sunny_outlined,
              color: value.getMode ? Colors.yellow : Colors.yellowAccent,
              size: value.getMode ? 14.0 : 26.0,
            ),
          ),
        ],
        isSelected: isSelected,
        onPressed: (int index) {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }
          Provider.of<ChangeModeProvider>(context, listen: false).setMode =
              isSelected[0];
        },
      );
    });
  }
}
