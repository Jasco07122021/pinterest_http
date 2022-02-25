import 'dart:convert';
import 'package:http/http.dart';
import '../models/collection_model.dart';

class HttpServer {
  ///API domain + header
  static String DOMAIN = "api.unsplash.com";
  static Map<String, String> header = {
    "Accept-Version": "v1",
    "Authorization": "Client-ID IuR29HU8Dj0Fpyz-i6kJA-wR6p0NArKTlR8qF-cdjho"
  };

  ///API posts
  static String API_LIST = "/photos";
  static String API_SEARCH = "search/photos";
  static String API_SEARCH_COLLECTIONS = "/search/collections";
  static String API_COLLECTIONS = "/collections";

  ///API methods
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var url = Uri.https(DOMAIN, api, params);
    Response response = await get(url, headers: header);
    if (response.statusCode == 200) {
      return response.body;
    }
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
