class InstaObject {
  final String thumnail;
  final String updateName;
  final String mediaUrl;
  final int unixTime;

  InstaObject({this.thumnail, this.updateName, this.mediaUrl, this.unixTime});

  String getThumnail() {
    return thumnail;
  }

  String getUpdateName() {
    return updateName;
  }

  String getPostDay() {
    var time =
        DateTime.fromMillisecondsSinceEpoch(unixTime * 1000, isUtc: true);
    var now = DateTime.now();
    var original = now.difference(time).inDays;
    if (original == 0) {
      return 'Posted Today';
    } else if (original == 1) {
      return '$original day ago';
    } else {
      return '$original days ago';
    }
  }

  String getMediaUrl() {
    if (mediaUrl == null) {
      return thumnail;
    } else
      return mediaUrl;
  }
}
