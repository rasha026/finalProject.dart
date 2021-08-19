



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'Album.dart';
import 'ThemeProvider.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    late Future<List<Album>> user;

    user = getData();

    return Consumer<MyThemes>( builder: (context, ob, child) {

      return FutureBuilder<List<Album>>(
        future: user,
        builder: (context, snapshot) {

            if (snapshot.hasData) {
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                 children: List.generate(snapshot.data!.length, (index) =>
                    Column(
                    children: [
                      Text("data"),
                      Image(image: NetworkImage("${snapshot.data![index].image}"),
                width: double.infinity,
                       fit: BoxFit.cover,),

                  ],

                ),
                ),


                ),
              );
            }





          return CircularProgressIndicator();
        }, );
    }
    );
  }


  }

