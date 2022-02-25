import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'result_search_page.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _header(),
      ),
    );
  }

  _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 50,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (value) async {
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultSearchPage(text: value)));
              },
              decoration: InputDecoration(
                hintText: "Search for ideas",
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: const Icon(
                  CupertinoIcons.camera_fill,
                  color: Colors.black,
                ),
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                isCollapsed: true,
                filled: true,
                fillColor: Colors.grey.shade200,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context,"back");
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
