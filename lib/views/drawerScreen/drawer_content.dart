import 'package:codm/konstants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerContent extends StatelessWidget {
  final double height;
  DrawerContent({this.height});
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeModeProvider>(builder: (context, value, child) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.15,
          ),
          Expanded(
            child: Text(
              kAppDescription,
              style: TextStyle(
                color: value.kModeContrastColor,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Developer Contact:\n\n',
              style: TextStyle(color: value.kModeContrastColor),
              children: <TextSpan>[
                TextSpan(
                  text: kMailId,
                  style: TextStyle(
                      color: value.kModeContrastColor,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final uri =
                          'mailto:$kMailId?subject=About CoDM App&body=Hey Sakthi,\n';
                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        Scaffold.of(context).showSnackBar(
                          kGetSnackBar('Sorry Couldn\'t open mail.'),
                        );
                      }
                    },
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
