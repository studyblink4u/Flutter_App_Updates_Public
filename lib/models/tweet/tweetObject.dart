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
    return mediaUrl;
  }

  String getTweetUrl() {
    return tweetUrl;
  }
}
