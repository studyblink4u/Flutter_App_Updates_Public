class TweetObject {
  final String updateName;
  final String language;
  final String mediaUrl;
  final String tweetUrl;

  TweetObject({this.language, this.updateName, this.mediaUrl, this.tweetUrl});

  String getUpdateName() {
    return updateName;
  }

  String getLanguage() {
    return language;
  }

  String getMediaUrl() {
    if (mediaUrl != null) {
      return mediaUrl;
    } else {
      return 'https://twitter.com/PlayCODMobile/photo';
    }
  }

  String getTweetUrl() {
    return tweetUrl;
  }
}
