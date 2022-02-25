import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pinterest_2022/models/collection_model.dart';

class HiveDB {
  static String nameHive = "pinterest";
  static var box = Hive.box(nameHive);

  static put(List<Collections> list) {
    List<String> response =
        List<String>.from(list.map((x) => jsonEncode(x.toJson())));
    box.put("collections", response);
  }

  static putSaved(List<Collections> list) {
    List<String> response =
        List<String>.from(list.map((x) => jsonEncode(x.toJson())));
    box.put("save", response);
  }

  static putUser(Map<String,String> map) {
    box.put("user", map);
  }

  static List<Collections> get() {
    List<String>? response = box.get("collections");
    if(response == null) return [];
    List<Collections> list = List<Collections>.from(
        response.map((x) => Collections.fromJson(jsonDecode(x))));
    return list;
  }

  static List<Collections> getSaved() {
    List<String>? response = box.get("save");
    if(response == null) return [];
    List<Collections> list = List<Collections>.from(
        response.map((x) => Collections.fromJson(jsonDecode(x))));
    return list;
  }

  static Map<dynamic,dynamic> getUser() {
    Map<dynamic,dynamic> map = box.get("user");
    return map;
  }

}
