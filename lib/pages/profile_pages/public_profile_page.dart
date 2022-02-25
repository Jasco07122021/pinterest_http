import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_sheet.dart';

class PublicProfilePage extends StatefulWidget {
  const PublicProfilePage({Key? key}) : super(key: key);

  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.95,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.back),
                  ),
                  MaterialButton(
                    child: const Text("Done"),
                    color: Colors.grey.shade200,
                    shape: const StadiumBorder(),
                    minWidth: 50,
                    onPressed: () {},
                  ),
                ],
              ),
              Widgets.text17BottomSheet(text: "Settings"),
            ],
          ),
        ],
      ),
    );
  }
}
