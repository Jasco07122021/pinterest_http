import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_2022/models/collection_model.dart';
import 'package:pinterest_2022/services/hive_db.dart';
import 'package:pinterest_2022/widgets/masonryGrid.dart';

import '../../widgets/bottom_sheet.dart';
import 'setting_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  List<Collections> list = [];
  Map<String, String> map = {};

  @override
  void initState() {
    super.initState();
    if (HiveDB.getSaved().isNotEmpty) {
      list = HiveDB.getSaved();
    }
    map = HiveDB.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          const Icon(Icons.share),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              _menuBottomSheet();
            },
            child: const Icon(
              Icons.more_horiz,
              size: 30,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            child: Text(
              map["name"]![0],
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          _headerText(),
          const SizedBox(height: 30),
          _search(),
          const SizedBox(height: 10),
          _bodyList(),
        ],
      ),
    );
  }

  Row _search() {
    return Row(
      children: [
        Flexible(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                prefixIcon: const Icon(CupertinoIcons.search),
                hintText: "Search your Pins",
                hintStyle: const TextStyle(color: Colors.grey),
                isCollapsed: true,
                contentPadding: const EdgeInsets.only(top: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.plus))
      ],
    );
  }

  Column _headerText() {
    return Column(
      children: [
        Text(
          map["name"]! + "\n" + map["surname"]!,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("0 followers"),
            SizedBox(width: 10),
            Text("0 following"),
          ],
        ),
      ],
    );
  }

  MasonryGridView _bodyList() {
    return MasonryGRID.masonryGridView(
      count: list.length,
      physics: const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      builder: (context, index) {
        return MasonryGRID.grid(list: list, context: context, index: index);
      },
    );
  }

  Future<dynamic> _menuBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.text17BottomSheet(text: "Options"),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                _showSetting();
              },
              child: Widgets.text20BottomSheet(text: "Settings"),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Widgets.text20BottomSheet(text: "Copy profile link"),
            ),
            const SizedBox(height: 20),
            Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.grey.shade200,
                shape: const StadiumBorder(),
                child: const Text("Close"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showSetting() {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (context) => const SettingPage(),
    );
  }
}
