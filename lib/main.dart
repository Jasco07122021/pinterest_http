import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pinterest_2022/models/theme_model.dart';
import 'package:pinterest_2022/pages/first_page.dart';
import 'package:pinterest_2022/pages/login_page/sign_in.dart';
import 'package:pinterest_2022/services/hive_db.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.nameHive);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  if (HiveDB.get().isNotEmpty) {
    HiveDB.box.delete("collections");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: (HiveDB.getUser().isEmpty) ? const SignInPage() : const FirstPage(),
    );
  }
}

// _loadDateDio() {
//   DioServer.GET(DioServer.API_COLLECTIONS, DioServer.paramsEmpty())
//       .then((value) {
//     if (value != null) _showDataDio(value);
//   });
// }
//
// _showDataDio(String response) async {
//   setState(() => list.addAll(DioServer.parseCollectionResponse(response)));
// }
//
// loadMoreDio(){
//   DioServer.GET(DioServer.API_COLLECTIONS,
//       DioServer.paramsLoadMore(page: loadMorePage))
//       .then((value) {
//     if (value != null) _showDataDio(value);
//   });
//   setState(() {
//     loadMorePage++;
//   });
// }
//
// _loadDateRetrofit(){
//   Dio dio = Dio();
//   RetrofitServer retrofit = RetrofitServer(dio);
//   retrofit.getCollections(DioServer.paramsEmpty()).then((value) { if (value != null) _showDataRetrofit(value);});
// }
//
// _showDataRetrofit(List<Collections> response) async {
//   setState(() => list.addAll(response));
// }

// _loadDateDio() {
//   DioServer.GET(DioServer.API_SEARCH_COLLECTIONS,
//       DioServer.paramsSearch(page: 1, query: widget.text))
//       .then((value) {
//     if (value != null) _showDataDio(value);
//   });
// }
//
// _showDataDio(String response) async {
//   Map<String, dynamic> map = jsonDecode(response);
//   setState(() => list.addAll(
//       DioServer.parseCollectionResponse(jsonEncode(map['results']))));
//   isLoading = false;
// }
//
// loadMoreDio() {
//   DioServer.GET(DioServer.API_SEARCH_COLLECTIONS,
//       DioServer.paramsLoadMore(page: loadMorePage, query: widget.text))
//       .then((value) {
//     if (value != null) _showDataDio(value);
//   });
//   setState(() {
//     loadMorePage++;
//   });
// }
