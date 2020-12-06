class RedditObject {
  final String thumnail;
  final String updateName;
  final String htmlText;
  final int unixTime;

  RedditObject({this.thumnail, this.updateName, this.htmlText, this.unixTime});

  String getThumnail() {
    return thumnail;
  }

  String getUpdateName() {
    return updateName;
  }

  String getHtmlText() {
    String body = htmlText.replaceAllMapped(RegExp(r'<a(.*?)</a>'), (match) {
      int start = match.group(0).indexOf('"');
      int end = match.group(0).lastIndexOf('"');
      String link = match.group(0).substring(start + 1, end);
      if (link.contains(RegExp(r'\.(jpe?g|png|gif|bmp)'))) {
        return '<img src="$link">';
      } else if (link.contains('player')) {
        var stringList = link.split('/');
        return '<video controls><source src="https://v.redd.it/${stringList[3]}/${stringList[4]}/asset/${stringList[6]}/DASHPlaylist.mpd"></video>';
      } else
        return match.group(0);
    });
    return body;
  }

  String getPostDay() {
    var time =
        DateTime.fromMillisecondsSinceEpoch(unixTime * 1000, isUtc: true);
    var now = DateTime.now();
    var original = now.difference(time).inDays;

    return 'Posted $original days ago';
  }
}
