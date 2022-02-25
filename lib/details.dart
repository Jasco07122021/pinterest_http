import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_2022/pages/home_page.dart';

import 'models/collection_model.dart';
import 'services/hive_db.dart';
import 'services/http_server.dart';
import 'widgets/bottom_sheet.dart';

class DetailsPinterest extends StatefulWidget {
  final Collections obj;

  const DetailsPinterest({Key? key, required this.obj}) : super(key: key);

  @override
  _DetailsPinterestState createState() => _DetailsPinterestState();
}

class _DetailsPinterestState extends State<DetailsPinterest> {
  int loadMorePage = 2;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  late Collections obj;
  List<Collections> list = [];
  List<Collections> listSave = [];


  _loadDate() async {
    HttpServer.GET(HttpServer.API_SEARCH_COLLECTIONS,
            HttpServer.paramsSearch(query: widget.obj.title))
        .then((value) {
      if (value != null) _showData(value);
    });
  }

  _showData(String response) async {
    Map<String, dynamic> map = jsonDecode(response);
    setState(() => list.addAll(
        HttpServer.parseCollectionResponse(jsonEncode(map['results']))));

  }

  loadMore() {
    HttpServer.GET(
        HttpServer.API_SEARCH_COLLECTIONS,
        HttpServer.paramsLoadMore(
          page: loadMorePage,
          query: widget.obj.title,
        )).then((value) {
      if (value != null) _showData(value);
    });

    setState(() {
      loadMorePage++;
    });
  }

  @override
  void initState() {
    super.initState();
    obj = widget.obj;
    _loadDate();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                _headerImg(),
                _headerBody(),
                const SizedBox(height: 1),
                _bodyList(),
              ],
            ),
            _appBar(),
          ],
        ),
      ),
    );
  }

  Padding _appBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }

  Stack _headerImg() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: obj.coverPhoto!.urls!.full!,
          placeholder: (context, url) => AspectRatio(
            aspectRatio: obj.coverPhoto!.width! / obj.coverPhoto!.height!,
            child: Container(
              color: obj.coverPhoto!.color!.toColor(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: _menuBottomSheet,
              child: const Icon(
                Icons.more_horiz,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _menuBottomSheet() {
    return Widgets.bottomSheetPadding(
      context: context,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(CupertinoIcons.clear)),
            const SizedBox(
              width: 20,
            ),
            Widgets.text17BottomSheet(text: "Options"),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
            onTap: () {}, child: Widgets.text20BottomSheet(text: "Copy link")),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {},
          child: Widgets.text20BottomSheet(text: "Download image"),
        ),
        const SizedBox(height: 20),
        Widgets.columnButtonBottomSheet(
            text20: "Hide Pin", text15: "See fewer Pins like this"),
        const SizedBox(height: 20),
        Widgets.columnButtonBottomSheet(
            text20: "Report Pin",
            text15: "This goes against Pinterest's Community Guidelines"),
      ],
    );
  }

  Container _headerBody() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: obj.coverPhoto!.user!.profileImage!.large!,
                  placeholder: (context, url) => AspectRatio(
                    aspectRatio:
                        obj.coverPhoto!.width! / obj.coverPhoto!.height!,
                    child: Container(
                      color: obj.coverPhoto!.color!.toColor(),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(obj.coverPhoto!.user!.name.toString()),
            subtitle: Text(
                obj.coverPhoto!.user!.totalPhotos.toString() + "k Followers"),
            trailing: MaterialButton(
              onPressed: () {},
              child: const Text("Follow"),
              color: Colors.grey.shade300,
              shape: const StadiumBorder(),
            ),
          ),
          if (obj.coverPhoto!.user!.bio != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                obj.coverPhoto!.user!.bio!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (obj.coverPhoto!.description != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                obj.coverPhoto!.description!,
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(CupertinoIcons.chat_bubble_fill),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: const StadiumBorder(),
                    color: Colors.grey.shade300,
                    child: const Text("Visit"),
                  ),
                  const SizedBox(width: 5),
                  MaterialButton(
                    onPressed: () {
                      setState(() {});
                      listSave.add(obj);
                      HiveDB.putSaved(listSave);
                    },
                    shape: const StadiumBorder(),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: const Text("Save"),
                  ),
                ],
              ),
              const Icon(Icons.share),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Container _bodyList() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            "More like this",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _scrollController2,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (index == list.length) {
                      return const SizedBox.shrink();
                    }
                    return _grid(index: index);
                  },
                ),
        ],
      ),
    );
  }

  GestureDetector _grid({index}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPinterest(obj: list[index])));
      },
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: list[index].coverPhoto!.urls!.regular!,
                placeholder: (context, url) => AspectRatio(
                  aspectRatio: list[index].coverPhoto!.width! /
                      list[index].coverPhoto!.height!,
                  child: Container(
                    color: list[index].coverPhoto!.color!.toColor(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            list[index].coverPhoto!.description != null
                ? bottomListTile(index: index)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Spacer(),
                        moreHorizontal(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  GestureDetector moreHorizontal() {
    return GestureDetector(
      onTap: () {
        Widgets.bottomSheetPadding(
          context: context,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(CupertinoIcons.clear),
                ),
                const SizedBox(width: 20),
                Widgets.text17BottomSheet(text: "Share to"),
              ],
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.only(top: 15),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Widgets.faangCompany(
                      text: "Send", img: "assets/images/img.png"),
                  const SizedBox(width: 20),
                  Widgets.faangCompany(
                      text: "Telegram", img: "assets/images/img_6.png"),
                  const SizedBox(width: 20),
                  Widgets.faangCompany(
                      text: "Facebook", img: "assets/images/img_2.png"),
                  const SizedBox(width: 20),
                  Widgets.faangCompany(
                      text: "Gmail", img: "assets/images/img_3.png"),
                  const SizedBox(width: 20),
                  Widgets.faangCompany(
                      text: "Copy link", img: "assets/images/img_4.png"),
                  const SizedBox(width: 20),
                  Widgets.faangCompany(
                      text: "More", img: "assets/images/img_5.png"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Widgets.text20BottomSheet(text: "Download image"),
            const SizedBox(height: 20),
            Widgets.text20BottomSheet(text: "Hide Pin"),
            const SizedBox(height: 20),
            Widgets.columnButtonBottomSheet(
                text20: "Report Pin",
                text15: "This goes against Pinterest's community guidelines"),
            const SizedBox(height: 40),
            Widgets.text15BottomSheet(
                text: "This Pin is inspired by your recent activity"),
          ],
        );
      },
      child: const Icon(
        Icons.more_horiz,
        size: 20,
      ),
    );
  }

  Padding bottomListTile({index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 30,
              imageUrl: list[index].coverPhoto!.user!.profileImage!.large!,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              list[index].coverPhoto!.description!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          moreHorizontal(),
        ],
      ),
    );
  }
}
