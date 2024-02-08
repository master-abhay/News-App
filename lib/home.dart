import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Early News"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
            margin: const EdgeInsets.fromLTRB(5, 1, 5, 2),
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value){
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
          )
        ],
      ),
    );
  }
}
