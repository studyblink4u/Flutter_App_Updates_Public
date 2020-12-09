import 'package:codm/customPaint.dart';
import 'package:codm/models/insta/instaOjectList.dart';
import 'package:codm/models/reddit/redditObjectList.dart';
import 'package:codm/models/tweet/tweetObjectList.dart';
import 'package:codm/utils/instaNetwork.dart';
import 'package:codm/utils/redditNetwork.dart';
import 'package:codm/utils/tweetNetwork.dart';
import 'package:codm/views/instaViews/instaListView.dart';
import 'package:codm/views/redditViews/redditListView.dart';
import 'package:codm/views/twitterViews/tweetListView.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget currentView;
  bool done;
  RedditObjectList redditObjectList;
  InstaObjectList instaObjectList;
  TweetObjectList tweetObjectList;
  TweetObjectList pinnedTweetObjectList;
  final FlareControls controls = FlareControls();
  String flareAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    done = false;
    // _getInsta();
    // _getReddit();
    _getTweet();
    flareAnimation = 'rotate right';
  }

  void playRight() {
    controls.play('rotate right');
  }

  void playLeft() {
    controls.play('rotate left');
  }

  _getReddit() async {
    if (redditObjectList == null) {
      var htmlBody = await RedditNetwork.getRedditData();
      redditObjectList = RedditObjectList(jsonResponse: htmlBody);
    }

    setState(() {
      currentView =
          RedditListView(redditObjects: redditObjectList.getObjectList());
      done = true;
    });
  }

  _getInsta() async {
    if (instaObjectList == null) {
      var htmlBody = await InstaNetwork.getInstaData();
      instaObjectList = InstaObjectList(jsonResponse: htmlBody);
    }
    setState(() {
      currentView =
          InstaListView(instaObjects: instaObjectList.getObjectList());
      done = true;
    });
  }

  _getTweet() async {
    if (tweetObjectList == null && pinnedTweetObjectList == null) {
      var htmlBody = await TweetNetwork.getTweetData();
      var pinnedTweetHtmlBody = await PinnedTweet.getPinnedTweet();

      pinnedTweetObjectList =
          TweetObjectList(jsonResponse: pinnedTweetHtmlBody);
      tweetObjectList = TweetObjectList(jsonResponse: htmlBody);
    }
    setState(() {
      currentView = TweetListView(
        tweetObjects: tweetObjectList.getObjectList(),
        pinnedTweetObjects: pinnedTweetObjectList.getObjectList(),
      );
      done = true;
    });
  }

  void setPage(index) {
    switch (index) {
      case 0:
        _getReddit();
        break;
      case 1:
        _getInsta();
        break;
      case 2:
        _getTweet();
        break;
      default:
        _getReddit();
    }
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: Colors.deepPurple,
          height: height * 0.15 >= 75.0 ? 50.0 : height * 0.15,
          index: 2,
          items: [Text('reddit'), Text('insta'), Text('tweet')],
          onTap: (index) {
            setState(() {
              done = false;
            });
            setPage(index);
          },
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                child: CustomPaint(
                  painter: MainScreenTopCustomPaint(),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.05,
                width: width * 0.15,
                child: Container(
                  height: 25.0,
                  width: 25.0,
                  child: FlareActor(
                    'assets/flare/menu_bar_translate.flr',
                    animation: flareAnimation,
                    controller: controls,
                    callback: (string) {
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          flareAnimation = flareAnimation == 'rotate right'
                              ? 'rotate left'
                              : 'rotate right';
                        });
                      });
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 50.0,
                  ),
                  Expanded(
                    child: Container(
                      child: done ? currentView : CircularProgressIndicator(),
                    ),
                  ),
                  Container(
                    height: 5.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.pink,
                          Colors.pinkAccent,
                          Colors.purpleAccent,
                          Colors.purple,
                          Colors.deepPurpleAccent,
                          Colors.deepPurple
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final url;
  WebViewPage({this.url});
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        widget.url,
        aspectRatio: 2.0,
      ),
    );
  }
}
