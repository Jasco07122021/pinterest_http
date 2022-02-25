import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_2022/details.dart';
import 'package:pinterest_2022/services/hive_db.dart';
import 'bottom_sheet.dart';

class MasonryGRID {
  static MasonryGridView masonryGridView(
      {builder, count, controller, physics}) {
    return MasonryGridView.count(
      controller: controller,
      physics: physics,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: count,
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      itemBuilder: builder,
    );
  }

  static GestureDetector grid({index, list, context}) {
    return GestureDetector(
      onTap: () {
        HiveDB.put(list);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPinterest(obj: list[index])));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: list[index].coverPhoto!.urls!.full!,
                placeholder: (context, url) => Container(
                  height: list[index].coverPhoto!.height! /
                      list[index].coverPhoto!.width! *
                      200,
                  //
                  color: Color.fromARGB(
                    Random().nextInt(256),
                    Random().nextInt(256),
                    Random().nextInt(256),
                    Random().nextInt(256),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            list[index].coverPhoto!.description != null
                ? bottomListTile(index: index, list: list, context: context)
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Spacer(),
                        moreHorizontal(context: context),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  static GestureDetector moreHorizontal({context}) {
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

  static Padding bottomListTile({index, list, context}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
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
          moreHorizontal(context: context),
        ],
      ),
    );
  }
}
