import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  //List of the NavBar Items
  List<String> navBarItem = [
    "Finance",
    "Health",
    "Top News",
    "India",
    "Finance",
    "Health",
    "Finance",
    "Health",
    "Top News",
    "India",
    "Finance",
    "Health"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Early News"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column
          (
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
                        print(value);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Let's cook something...",
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
                        // If the text is not blank, perform the search
                        // getRecipe(searchController.text);

                        // Clear the search input field
                        // searchController.clear();

                        // Navigate to the same screen with the new query
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Search(
                        //       querry: searchController.text,
                        //     ),
                        //   ),
                        // );
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
                          print(navBarItem[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            navBarItem[index],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      );
                    })),
//Creating the CarouselSlider
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.7,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: items.map((item) {
                return Builder(builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Card(
                        child: Stack(
                          children: [
                            Image.asset(
                              "images/card_image.jpg",
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 130,
                              left: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Colors.black12.withOpacity(0),
                                  Colors.black12.withOpacity(1)
                                ])),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NEWS Headline",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      Text(
                                        "Description........",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
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

            //Creating the Cards with scrollable listView

            //Adding Text
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Latest News",style: textStyle,),],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                            Image.asset("images/card_image.jpg"),
                            Positioned(
                                top: 220,
                                right: 0,
                                bottom: 0,
                                left: 20,
                                child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.black12.withOpacity(0),
                                      Colors.black.withOpacity(1)
                                    ])),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("News Headline",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text("News Description",
                                              style: TextStyle(
                                                  color: Colors.white))
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
              onPressed: () {},
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
