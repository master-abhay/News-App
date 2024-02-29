import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:app_news/category.dart';
import 'package:app_news/model.dart';
import 'package:app_news/showMore.dart';
import 'package:app_news/webView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  //List of the NavBar Items
  List<String> navBarItem = [
    "Technology",
    "Science",
    "Entertainment",
    "Sports",
    "Health"
  ];

  // Section for creating the models of the news:

  // List for Storing the models of ListViewSlider not CarouselSlider:
  List<NewsQueryModel> newsQueryModelList = <NewsQueryModel>[];

  bool isLoading = true;

  Future<void> getNewsByQuery(String query) async {
    //Accessing Currrent Date for the news Updates:

    DateTime now = DateTime.now();
    String nowInString = now.toString();
    nowInString = nowInString.substring(0, 11);

    String url =
        "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=61dac02ee57c4f6f94b3f7cd0c67e291";

    Response response = await get(Uri.parse(url));
    Map data = await jsonDecode(response.body);
    //This statement is just for the testing purpose so that we can check that correct data we getting or not. It can also be removed.
    log(data.toString());


int i=0;
    try{
      for(Map element in data['articles']){
        i++;
        NewsQueryModel model = NewsQueryModel.fromMap(element);
        newsQueryModelList.add(model);
        setState(() {
          isLoading = false;
        });

        if(i == 5){
          break;
        }

      }

    }catch(e){
      print(e);
    };

  }

  bool isLoadingCarousel = true;

  //list for Storing the models of the Carousel Slider:
  List<NewsQueryModel> newsQueryModelCarouselList = <NewsQueryModel>[];

  Future<void> getCarouselSliderQuery() async {
    String url =
        await "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=61dac02ee57c4f6f94b3f7cd0c67e291";
    // String url = await "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=61dac02ee57c4f6f94b3f7cd0c6";
    Response response = await get(Uri.parse(url));
    Map data = await jsonDecode(response.body);
    data['articles'].forEach((element) {
      NewsQueryModel model = NewsQueryModel.fromMap(element);
      newsQueryModelCarouselList.add(model);

      //To check that
      log(newsQueryModelCarouselList.toString());
      setState(() {
        isLoadingCarousel = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsQueryModelList.clear();
    newsQueryModelCarouselList.clear();
    getNewsByQuery("aaj tak");
    getCarouselSliderQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Early News"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              margin: const EdgeInsets.fromLTRB(5, 1, 5, 2),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        if ((value).replaceAll(' ', '') != '') {
                          // Clear the search input field
                          // searchController.clear();

                          // Navigate to the same screen with the new query
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowMore(
                                showMore: value,
                              ),
                            ),
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Find News...",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text).replaceAll(' ', '') != '') {
                        // Clear the search input field
                        // searchController.clear();

                        // Navigate to the same screen with the new query
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowMore(
                              showMore: searchController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      size: 40,
                      color: Color(0xffad5389),
                    ),
                  ),
                ],
              ),
            ),

            //navBAR
            Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: navBarItem.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Category(
                                        categoryText: navBarItem[index],
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            navBarItem[index],
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      );
                    })),

//Creating the CarouselSlider
            Container(
              child: Column(
                children: [
                  isLoadingCarousel
                      ? const CircularProgressIndicator()
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 180.0,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 2),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: newsQueryModelCarouselList.map((item) {
                            return Builder(builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WebView(url: item.newsUrl)));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Card(
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          item.newsImage,
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                        Positioned(
                                          top: 130,
                                          left: 10,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  Colors.black12.withOpacity(0),
                                                  Colors.black12.withOpacity(1)
                                                ])),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (item.newsHeading.length >
                                                            35)
                                                        ? item.newsHeading
                                                                .substring(
                                                                    0, 33) +
                                                            "..."
                                                        : item.newsHeading +
                                                            "...",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    (item.newsDescription
                                                                .length >
                                                            35)
                                                        ? item.newsDescription
                                                                .substring(
                                                                    0, 33) +
                                                            "..."
                                                        : item.newsDescription +
                                                            "...",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  )
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                ],
              ),
            ),

            //Creating the Cards with scrollable listView

            //Adding Text
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latest News",
                    style: textStyle,
                  ),
                ],
              ),
            ),

            isLoading
                ? const CircularProgressIndicator()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newsQueryModelList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebView(
                                      url: newsQueryModelList[index].newsUrl)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.black12
                                                    .withOpacity(0.30),
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
                                                            newsQueryModelList[
                                                                            index]
                                                                        .newsHeading
                                                                        .length <
                                                                    60
                                                                ? newsQueryModelList[
                                                                        index]
                                                                    .newsHeading
                                                                    .length
                                                                : 60),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "${newsQueryModelList[index].newsDescription.substring(0, newsQueryModelList[index].newsDescription.length < 50 ? newsQueryModelList[index].newsDescription.length : 50)}.......",
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

            // Creting Show More Button
            ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowMore(showMore: "Aaj Tak")));
              },
              child: Text(
                'show more',
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  // list for the Carousel slider:
  final List items = [Colors.amber, Colors.green, Colors.blueAccent];

  //Creating the Button Style
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.blue,
    backgroundColor: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  //Creating the TextStyle
  final TextStyle textStyle = const TextStyle(
      color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20.0);
}
