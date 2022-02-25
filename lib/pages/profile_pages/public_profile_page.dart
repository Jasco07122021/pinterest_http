import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/hive_db.dart';
import '../../widgets/bottom_sheet.dart';

class PublicProfilePage extends StatefulWidget {
  const PublicProfilePage({Key? key}) : super(key: key);

  @override
  _PublicProfilePageState createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  Map<dynamic, dynamic> map = {};
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;

  @override
  void initState() {
    super.initState();
    map = HiveDB.getUser();
    controllerName = TextEditingController(text: map["name"]!);
    controllerSurname = TextEditingController(text: map["surname"]!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(
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
                    color: Theme.of(context).backgroundColor,
                    shape: const StadiumBorder(),
                    minWidth: 50,
                    onPressed: () {},
                  ),
                ],
              ),
              Widgets.text17BottomSheet(text: "Settings"),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: Text(
                    map["name"]![0].toString().toUpperCase(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Edit"),
                  shape: const StadiumBorder(),
                  color: Theme.of(context).backgroundColor,
                  elevation: 1,
                ),
              ],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: controllerName.text,
              enabledBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
