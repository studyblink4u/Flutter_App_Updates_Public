import 'package:codm/animations/movingDot.dart';
import 'package:codm/customPaint.dart';
import 'package:codm/models/insta/instaOjectList.dart';
import 'package:codm/models/reddit/redditObjectList.dart';
import 'package:codm/models/tweet/tweetObjectList.dart';
import 'package:codm/screenSize.dart';
import 'package:codm/utils/instaNetwork.dart';
import 'package:codm/utils/redditNetwork.dart';
import 'package:codm/utils/tweetNetwork.dart';
import 'package:codm/views/instaViews/instaListView.dart';
import 'package:codm/views/redditViews/redditListView.dart';
import 'package:codm/views/twitterViews/tweetListView.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize(size: WidgetsBinding.instance.window.physicalSize);
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
  String flutterAnimation;
  MovingDot classMovingDots = MovingDot();
  List<Widget> dots;
  List<Widget> bottomDots;
  List<bool> isSelected;
  int _index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = [true, false];
    done = false;
    _getInsta();
    // _getReddit();
    // _getTweet();
    flutterAnimation = 'rotate left';
    dots = classMovingDots.getDots(dotCount: 300);
    bottomDots = classMovingDots.getDots(dotCount: 100);
  }

  _getReddit() async {
    if (redditObjectList == null) {
      var htmlBody = await RedditNetwork.getRedditData();
      redditObjectList = RedditObjectList(jsonResponse: htmlBody);
    }

    setState(() {
      _index = 0;
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
      _index = 1;
      currentView = InstaListView(
          instaObjects: instaObjectList.getObjectList(), mode: isSelected[0]);
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
      _index = 2;
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

  Color getColor(bool state) {
    return state ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: done
            ? CurvedNavigationBar(
                index: _index,
                dots: isSelected[0] ? bottomDots : [],
                color: getColor(isSelected[0]),
                height: height * 0.15 >= 75.0 ? 50.0 : height * 0.15,
                items: [
                  Text(
                    'reddit',
                    style: TextStyle(color: getColor(isSelected[1])),
                  ),
                  Text(
                    'insta',
                    style: TextStyle(color: getColor(isSelected[1])),
                  ),
                  Text(
                    'tweet',
                    style: TextStyle(color: getColor(isSelected[1])),
                  )
                ],
                onTap: (index) {
                  setState(() {
                    done = false;
                  });
                  setPage(index);
                },
              )
            : Container(
                color: Colors.transparent,
                height: 0.1,
              ),
        body: Container(
          child: Stack(
            children: [
              Container(
                color: isSelected[0] ? Colors.black : Colors.white,
                child: isSelected[0]
                    ? Stack(
                        children: dots,
                      )
                    : Container(),
              ),
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
                    animation: flutterAnimation,
                    controller: controls,
                    callback: (string) {
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          flutterAnimation = string == 'rotate right'
                              ? 'rotate left'
                              : 'rotate right';
                        });
                      });
                    },
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: height * 0.12,
                  ),
                  Expanded(
                    child: Container(
                      width: width * 0.90,
                      child: done
                          ? Container(child: Center(child: currentView))
                          : Container(
                              height: 100.0,
                              width: 100.0,
                              child: CircularProgressIndicator(),
                            ),
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
              Positioned(
                top: height * 0.05,
                left: width * 0.70,
                child: ToggleButtons(
                  borderColor: Colors.black,
                  fillColor: Colors.grey,
                  borderWidth: 2,
                  selectedBorderColor: Colors.black,
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  children: [
                    Icon(Icons.wb_sunny_outlined),
                    Icon(Icons.nightlight_round)
                  ],
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
                  },
                ),
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
