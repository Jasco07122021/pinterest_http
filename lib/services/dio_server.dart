import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/collection_model.dart';

class DioServer{
  static Map<String, String> header = {
    "Accept-Version": "v1",
    "Authorization": "Client-ID IuR29HU8Dj0Fpyz-i6kJA-wR6p0NArKTlR8qF-cdjho"
  };

  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "https://api.unsplash.com";
  static String SERVER_PRODUCTION = "https://api.unsplash.com";

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  static var options = BaseOptions(
    baseUrl: getServer(),
    headers: header,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  ///API posts
  static String API_LIST = "/photos";
  static String API_SEARCH = "search/photos";
  static String API_SEARCH_COLLECTIONS = "/search/collections";
  static String API_COLLECTIONS = "/collections";


  ///API methods
  static Future<String?> GET(String api, Map<String,dynamic> params) async{
    Response response = await Dio(options).get(api, queryParameters: params);
    if (response.statusCode == 200) return jsonEncode(response.data);
    return null;
  }

  ///API functions
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> map = {};
    return map;
  }

  static Map<String, dynamic> paramsSearch({page, query}) {
    Map<String, dynamic> map = {};
    map.addAll({"page": page.toString(), "query": query});
    return map;
  }

  static Map<String, dynamic> paramsLoadMore({page, query}) {
    Map<String, dynamic> map = {};
    map.addAll({"page": page.toString(), "query": query});
    return map;
  }

  static List<Collections> parseCollectionResponse(String response) {
    List json = jsonDecode(response);
    List<Collections> collections =
    List<Collections>.from(json.map((x) => Collections.fromJson(x)));
    return collections;
  }

}