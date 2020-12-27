class TweetObject {
  final String updateName;
  final String language;
  final String mediaUrl;
  final String tweetUrl;
  final String profilePhotoUrl;

  TweetObject(
      {this.language,
      this.updateName,
      this.mediaUrl,
      this.tweetUrl,
      this.profilePhotoUrl});

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
      return 'https://pbs.twimg.com/profile_banners/1166443278834659328/1608595807/600x200';
    }
  }

  String getTweetUrl() {
    return tweetUrl ?? 'https://twitter.com/PlayCODMobile';
  }
}
