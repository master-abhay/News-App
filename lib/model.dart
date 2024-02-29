class NewsQueryModel {
  late String newsHeading;
  late String newsDescription;
  late String newsImage;
  late String newsUrl;

  NewsQueryModel(
      {this.newsHeading = "Some Heading",
      this.newsDescription = "Some Description",
      this.newsImage = "Some Image",
      this.newsUrl = "SomeUrl"});

  //Factory Constructor for returning instances as we need and storing the instances in the list which is located in home.dart.
  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
        newsHeading: news["title"],
        newsDescription: news["description"],
        newsImage: news["urlToImage"],
        newsUrl: news["url"]);
  }
}
