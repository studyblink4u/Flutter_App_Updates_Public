import 'package:codm/konstants.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HtmlViewPage extends StatefulWidget {
  final String body;
  HtmlViewPage({this.body});
  @override
  _HtmlViewPageState createState() => _HtmlViewPageState();
}

class _HtmlViewPageState extends State<HtmlViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<ChangeModeProvider>(builder: (context, value, child) {
            return Container(
              padding: EdgeInsets.all(7.5),
              color: value.getModeColor,
              child: HtmlWidget(
                (widget.body).toString(),
                textStyle: TextStyle(
                  color: value.getModeContrastColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  fontFamily: GoogleFonts.sourceSansPro().toString(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
