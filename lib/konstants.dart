import 'package:codm/models/insta/instaOjectList.dart';
import 'package:codm/models/reddit/redditObjectList.dart';
import 'package:codm/models/tweet/tweetObjectList.dart';
import 'package:codm/utils/instaNetwork.dart';
import 'package:codm/utils/redditNetwork.dart';
import 'package:codm/utils/tweetNetwork.dart';
import 'package:codm/views/instaViews/insta_list_view.dart';
import 'package:codm/views/redditViews/reddit_list_view.dart';
import 'package:codm/views/twitterViews/tweet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

RegExp kRegexUrl = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)');

String kMailId = 'studyblink4u@gmail.com';

String kAppDescription =
    'About: \n\nA Simple App which brings recent updates on a game.\n';

List<Color> kLongGradient = [
  Colors.pink,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.purple,
  Colors.deepPurpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.purple,
  Colors.deepPurpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.pink,
];

List<Color> kCurvedNavigationBarTop = [
  Colors.pink,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.purple,
  Colors.deepPurpleAccent,
  Colors.deepPurple
];

SnackBar kGetSnackBar(String content) {
  return SnackBar(
    content: Text(content),
  );
}

double kGetCurvedNavigationBarHeight(double height) {
  return height * 0.15 >= 75.0 ? 50.0 : height * 0.15;
}

Container kFullHeightContainer = Container(
  width: 2.0,
  decoration: BoxDecoration(
    gradient: LinearGradient(
        colors: kLongGradient,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  ),
);

Container kFullWidthContainer = Container(
  height: 2.0,
  decoration: BoxDecoration(
    gradient: LinearGradient(
        colors: kCurvedNavigationBarTop,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight),
  ),
);

class ChangeModeProvider with ChangeNotifier {
  ModePreference modePreference = ModePreference();
  bool mode = true;
  Color kModeColor = Colors.black;
  Color kModeContrastColor = Colors.white;

  bool get getMode => mode;

  Color get getModeColor => kModeColor;

  Color get getModeContrastColor => kModeContrastColor;

  set setMode(bool value) {
    mode = value;
    kModeColor = value ? Colors.black : Colors.white;
    kModeContrastColor = !value ? Colors.black : Colors.white;
    notifyListeners();
  }
}

class ModePreference {
  static const mode = 'Dark';

  setMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(mode, value);
  }

  Future<bool> getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(mode) ?? true;
  }
}

class FetchData with ChangeNotifier {
  bool _isLoading = true;
  int index = 0;
  Widget _currentWidgetList;
  Widget _redditWidgetList;
  Widget _instaWidgetList;
  Widget _tweetWidgetList;

  FetchData() {
    setCurrentWidgetList = 0;
  }

  bool get getLoadingStatus => _isLoading;

  set setLoadingStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int get getIndex => index;

  Widget get getCurrentWidgetList => _currentWidgetList;

  set setCurrentWidgetList(int media) {
    switch (media) {
      case 0:
        if (_redditWidgetList == null) {
          _getRedditData();
        } else {
          _currentWidgetList = _redditWidgetList;
          setLoadingStatus = false;
        }
        index = 0;
        break;
      case 1:
        if (_instaWidgetList == null) {
          _getInstaData();
        } else {
          _currentWidgetList = _instaWidgetList;
          setLoadingStatus = false;
        }
        index = 1;
        break;
      case 2:
        if (_tweetWidgetList == null) {
          _getTweetData();
        } else {
          _currentWidgetList = _tweetWidgetList;
          setLoadingStatus = false;
        }
        index = 2;
        break;
      default:
        _currentWidgetList = Center(
          child: Container(
            child: Text(
              'OOPS!!! Sorry for inconvenience',
              style: TextStyle(fontSize: 18.0, color: Colors.red),
            ),
          ),
        );
    }
  }

  _getRedditData() async {
    var jsonResponse = await RedditNetwork.getRedditData();
    if (jsonResponse == 'Timeout' || jsonResponse == 'Socket') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCheck your Internet and try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else if (jsonResponse == 'JsonFormat') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCouldn\'t fetch data...Try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else {
      RedditObjectList _redditObjectList =
          RedditObjectList(jsonResponse: jsonResponse);
      _redditWidgetList =
          RedditListView(redditObjects: _redditObjectList.getObjectList());
      _currentWidgetList = _redditWidgetList;
      setLoadingStatus = false;
    }
  }

  _getInstaData() async {
    var jsonResponse = await InstaNetwork.getInstaData();
    if (jsonResponse == 'Timeout' || jsonResponse == 'Socket') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCheck your Internet and try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else if (jsonResponse == 'JsonFormat') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCouldn\'t fetch data...Try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else {
      InstaObjectList _instaObjectList =
          InstaObjectList(jsonResponse: jsonResponse);
      _instaWidgetList =
          InstaListView(instaObjects: _instaObjectList.getObjectList());
      _currentWidgetList = _instaWidgetList;
      setLoadingStatus = false;
    }
  }

  _getTweetData() async {
    var jsonResponse = await TweetNetwork.getTweetData();
    var pinnedTweetJsonResponse = await PinnedTweet.getPinnedTweet();
    TweetObjectList tweetObjectList;
    TweetObjectList pinnedTweetObjectList;
    if (jsonResponse == 'Timeout' || jsonResponse == 'Socket') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCheck your Internet and try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else if (jsonResponse == 'JsonFormat') {
      _currentWidgetList = Center(
        child: Container(
          child: Text(
            'Something went wrong!!!! \nCouldn\'t fetch data...Try another social media',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      setLoadingStatus = false;
    } else {
      tweetObjectList = TweetObjectList(jsonResponse: jsonResponse);
      if (pinnedTweetJsonResponse != null) {
        pinnedTweetObjectList =
            TweetObjectList(jsonResponse: pinnedTweetJsonResponse);
      }
      _tweetWidgetList = TweetListView(
          tweetObjects: tweetObjectList.getObjectList(),
          pinnedTweetObjects: pinnedTweetObjectList?.getObjectList());
      _currentWidgetList = _tweetWidgetList;
      setLoadingStatus = false;
    }
  }
}
