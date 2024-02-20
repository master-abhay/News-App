import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                              color: const Color(0xffff14900),
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
                height: 200.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
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
                    onTap: () {
                      print("Current Color is $item");
                    },
                    child: Container(
                      decoration: BoxDecoration(color: item),
                    ),
                  );
                });
              }).toList(),
            ),

            //Creating the Cards with scrollable listView

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      clipBehavior: Clip.hardEdge,
                      child: Card(
                          elevation: 30,
                          shadowColor: Colors.amber,
                          child: Stack(children: [
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              height: MediaQuery.of(context).size.height - 550,
                              width: MediaQuery.of(context).size.width,
                              child: Text("This is Card"),
                            ),
                          ])),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  // list for the Carousel slider:
  final List items = [Colors.amber, Colors.green, Colors.blueAccent];
}
