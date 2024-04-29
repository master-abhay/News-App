import 'package:flutter/material.dart';
import 'package:app_news/model.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:app_news/webView.dart';






class Category extends StatefulWidget {
  const Category({super.key, required this.categoryText});

  final String categoryText;

  @override
  State<Category> createState() => _CategoryState();


}



class _CategoryState extends State<Category> {


  List<NewsQueryModel> newsQueryModelList = <NewsQueryModel>[];
  bool isLoading = true;

  Future<void> getNewsByQuery(String query,String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=61dac02ee57c4f6f94b3f7cd0c67e291";
// String url = "https://newsapi.org/v2/everything?q=$category&sortBy=publishedAt&apiKey=61dac02ee57c4f6f94b3f7cd0c67e291";
    Response response = await get(Uri.parse(url));
    Map data = await jsonDecode(response.body);
    //This statement is just for the testing purpose so that we can check that correct data we getting or not. It can also be removed.
    log(data.toString());

    data['articles'].forEach((element) {
      NewsQueryModel model = NewsQueryModel.fromMap(element);
      newsQueryModelList.add(model);

      //To check that
      log(newsQueryModelList.toString());

      //setting state to false
      setState(() {
        isLoading = false;
      });

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery("in",widget.categoryText);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryText
        ),
      ),
      body:

      SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: newsQueryModelList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebView(url: newsQueryModelList[index].newsUrl)));
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                      child: Card(
                          elevation: 15,
                          shadowColor: Colors.purpleAccent,
                          child: Stack(children: [
                            Image.network(
                              newsQueryModelList[index].newsImage,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 250,
                            ),
                            Positioned(
                                top: 170,
                                right: 0,
                                bottom: 0,
                                left: 0,
                                child: Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black12.withOpacity(0.30),
                                              Colors.black.withOpacity(0.80)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.center)),
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              newsQueryModelList[index]
                                                  .newsHeading
                                                  .substring(
                                                  0,
                                                  newsQueryModelList[index]
                                                      .newsHeading
                                                      .length <
                                                      50
                                                      ? newsQueryModelList[
                                                  index]
                                                      .newsHeading
                                                      .length
                                                      : 50),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "${newsQueryModelList[index].newsDescription.substring(0, newsQueryModelList[index].newsDescription.length < 45 ? newsQueryModelList[index].newsDescription.length : 45)}.......",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10)),
                                        ])))
                          ])),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
