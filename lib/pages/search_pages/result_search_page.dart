import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_2022/models/collection_model.dart';
import 'package:pinterest_2022/services/http_server.dart';
import 'package:pinterest_2022/widgets/masonryGrid.dart';

import 'searching_page.dart';

class ResultSearchPage extends StatefulWidget {
  late String text;

  ResultSearchPage({Key? key, required this.text}) : super(key: key);

  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  TextEditingController controller = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  bool isLoading = true;
  int loadMorePage = 2;
  List<Collections> list = [];

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  _loadDateHttp() {
    HttpServer.GET(HttpServer.API_SEARCH_COLLECTIONS,
            HttpServer.paramsSearch(page: 1, query: widget.text))
        .then((value) {
      if (value != null) _showDataHttp(value);
    });
  }

  _showDataHttp(String response) async {
    Map<String, dynamic> map = jsonDecode(response);
    setState(() => list.addAll(
        HttpServer.parseCollectionResponse(jsonEncode(map['results']))));
    isLoading = false;
  }

  loadMoreHttp() {
    HttpServer.GET(HttpServer.API_SEARCH_COLLECTIONS,
        HttpServer.paramsLoadMore(page: loadMorePage, query: widget.text))
        .then((value) {
      if (value != null) _showDataHttp(value);
    });
    setState(() {
      loadMorePage++;
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDateHttp();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreHttp();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : _bodyList(),
            _header(),
          ],
        ),
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
          IconButton(
            onPressed: () {
              Navigator.pop(context, "back");
            },
            icon: const Icon(CupertinoIcons.left_chevron),
          ),
          Flexible(
            child: TextField(
              controller: controller,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchingPage()));
                FocusScope.of(context).unfocus();
              },
              focusNode: myFocusNode,
              decoration: InputDecoration(
                hintText: widget.text,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding:
                    const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                isCollapsed: true,
                filled: true,
                fillColor: Colors.grey.shade200,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyList() {
    return list.isEmpty
        ? const Center(
            child: Text("No data"),
          )
        : ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              const SizedBox(
                height: 50,
              ),
              MasonryGRID.masonryGridView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController2,
                  count: list.length,
                  builder: (context, index) {
                    if (index == list.length) {
                      return const SizedBox.shrink();
                    }
                    return MasonryGRID.grid(
                        index: index, context: context, list: list);
                  })
            ],
          );
  }
}
