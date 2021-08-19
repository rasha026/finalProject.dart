
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Album.dart';

class Http{

  Future<List<Album>> getData() async {
    var url = "http://fakestoreapi.com/products/";
    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Album> allUsers = [];
      for (var u in data) {
        Album album = Album.fromJson(u);
        allUsers.add(album);

      }
      return allUsers;
    } else
      throw Exception("Error");
  }
}