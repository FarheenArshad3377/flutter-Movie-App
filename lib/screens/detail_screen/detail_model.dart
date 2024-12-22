import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;

class DetailModel extends BaseViewModel {
  Map<String, dynamic> detailScreenData = {};

  Future<void> getDetailScreenMovies(int movieID) async {
    setBusy(true);
    try {
      var url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieID?api_key=3ac1e61a226df273e868dd0dd0c56dcb");
      var response = await https.get(url);

      if (response.statusCode == 200) {
        detailScreenData = jsonDecode(response.body);
      } else {
        detailScreenData = {"error": "Failed to fetch data"};
      }
    } catch (e) {
      detailScreenData = {"error": e.toString()};
    }
    setBusy(false);
    notifyListeners();
  }
  
}
