import 'package:flutter/material.dart';
import 'package:pinterest_2022/models/collection_model.dart';
import 'package:pinterest_2022/services/hive_db.dart';
import 'package:pinterest_2022/services/http_server.dart';
import 'package:pinterest_2022/widgets/masonryGrid.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  List<Collections> list = [];
  int loadMorePage = 2;
  final ScrollController _scrollController = ScrollController();

  _loadDateHttp() {
    HttpServer.GET(HttpServer.API_COLLECTIONS, HttpServer.paramsEmpty())
        .then((value) {
      if (value != null) _showDataHttp(value);
    });
  }

  _showDataHttp(String response) async {
    setState(() => list.addAll(HttpServer.parseCollectionResponse(response)));
  }

  loadMoreHttp() {
    HttpServer.GET(HttpServer.API_COLLECTIONS,
        HttpServer.paramsLoadMore(page: loadMorePage))
        .then((value) {
      if (value != null) _showDataHttp(value);
    });
    setState(() {
      loadMorePage++;
    });
  }


  @override
  void initState() {
    super.initState();

    if (HiveDB.get().isEmpty) {
      _loadDateHttp();
    } else {
      list = HiveDB.get();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreHttp();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    list = HiveDB.get();
  }

  @override
  void dispose() {
    super.dispose();
    HiveDB.put(list);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: _leadingAppBar(),
      ),
      body: SafeArea(
        child: MasonryGRID.masonryGridView(
          count: list.length + 1,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          builder: (context, index) {
            if (index == list.length) {
              return const SizedBox.shrink();
            }
            return MasonryGRID.grid(index: index, list: list, context: context);
          },
        ),
      ),
    );
  }

  Container _leadingAppBar() {
    return Container(
      margin: const EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: 10,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black,
      ),
      child: const Text("All"),
    );
  }
}
