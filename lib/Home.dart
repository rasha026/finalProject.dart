import 'dart:convert';
import 'dart:core';
import 'package:badges/badges.dart';
import 'package:final_project4/Album.dart';
import 'package:final_project4/ListStructure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'EditProfile.dart';
import 'Login.dart';
import 'ThemeProvider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List myData = [];

  @override
  Widget build(BuildContext context) {
    Future<List<Album>> getData() async {
      var url = "http://fakestoreapi.com/products/";
      var jsonData = await http.get(Uri.parse(url));

      if (jsonData.statusCode == 200) {
        List data = jsonDecode(jsonData.body);
        myData = data;
        print(myData);
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


    return Scaffold(
      backgroundColor: Provider.of<MyThemes>(context).backGroundColor,
      appBar: AppBar(
        backgroundColor: Provider.of<MyThemes>(context).backGroundColor,
        title: Text(
          "DSC SHOP",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  TextEditingController _searchItem = TextEditingController();
                  return Consumer<MyThemes>(builder: (context, ob, child) {
                    return AlertDialog(
                      backgroundColor: Colors.blueGrey,
                      title: Text("Search"),
                      content: TextField(
                          controller: _searchItem,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          )),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            ob.setSearchItem(_searchItem.text);
                          },
                          child: Text("Search",
                              style: TextStyle(
                                color: Provider.of<MyThemes>(context).textColor,
                              )),
                        )
                      ],
                    );
                  });
                },
              );
            },
          ),
        ],
      ),
      body: ListStructure(),
      drawer: Drawer(
        child: Container(
          color: Provider.of<MyThemes>(context).backGroundColor,
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Consumer<MyThemes>(builder: (context, ob, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: InkWell(
                            child: Image.asset("images/splash.png"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${ob.name}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Provider.of<MyThemes>(context).textColor,
                          ),
                        ),
                        Text(
                          "${ob.mail}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Provider.of<MyThemes>(context).textColor,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<MyThemes>(builder: (context, ob, child) {
                return Flexible(
                  flex: 3,
                  child: ListTile(
                    title: Text("dark mode",
                        style: TextStyle(
                          color: Provider.of<MyThemes>(context).textColor,
                        )),
                    trailing: Switch(
                      onChanged: (value) {
                        ob.setDarkMode();
                        value = ob.darkModeSelected;
                      },
                      value: ob.darkModeSelected,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.blueGrey,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                    leading: Icon(
                      Icons.nightlight_round,
                      color: Provider.of<MyThemes>(context).textColor,
                    ),
                  ),
                );
              }),
              Consumer<MyThemes>(builder: (context, ob, child) {
                return Column(
                  children: [
                    ListTile(
                      selectedTileColor: Colors.black87,
                      leading: Icon(Icons.info,
                          color: Provider.of<MyThemes>(context).textColor),
                      title: Text("about",
                          style: TextStyle(
                            color: Provider.of<MyThemes>(context).textColor,
                          )),
                      onTap: () {
                        ob.changSelectedAbout();
                      },
                    ),
                    if (ob.selectedAbout)
                      Text("Version 1.0.0",
                          style: TextStyle(
                            fontSize: 15,
                            color: Provider.of<MyThemes>(context).textColor,
                          )),
                  ],
                );
              }),
              Consumer<MyThemes>(builder: (context, ob, child) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.language,
                          color: Provider.of<MyThemes>(context).textColor),
                      title: Text("Language",
                          style: TextStyle(
                            color: Provider.of<MyThemes>(context).textColor,
                          )),
                      onTap: () {
                        ob.changSelectedLanguage();
                      },
                      selectedTileColor: Colors.black87,
                    ),
                    if (ob.selectedALanguage)
                      InkWell(
                        child: Text("English",
                            style: TextStyle(
                              fontSize: 15,
                              color: Provider.of<MyThemes>(context).textColor,
                            )),
                        onTap: () {},
                      ),
                    if (ob.selectedALanguage)
                      InkWell(
                        child: Text("Arabic",
                            style: TextStyle(
                              fontSize: 15,
                              color: Provider.of<MyThemes>(context).textColor,
                            )),
                        onTap: () {},
                      ),
                  ],
                );
              }),
              Center(
                child: Container(
                  child: ListTile(
                    leading: Icon(Icons.logout,
                        color: Provider.of<MyThemes>(context).textColor),
                    title: Text("Log out",
                        style: TextStyle(
                          color: Provider.of<MyThemes>(context).textColor,
                        )),
                    onTap: () {
                      logOut(context);
                    },
                    selectedTileColor: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<MyThemes>(
        builder: (context, ob, child) {
          return BottomNavigationBar(
            backgroundColor: Provider.of<MyThemes>(context).backGroundColor,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.border_all_rounded),
                label: "All",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                label: "shopping cart",
                icon: Badge(

                  badgeColor: Colors.cyan,
                  shape: BadgeShape.circle,
                  borderRadius: BorderRadius.circular(100),
                  child: Icon(Icons.shopping_cart),
                  badgeContent: Text("${ob.counter}"),

                  ),

                ),
            ],
            currentIndex: ob.index,
            onTap: (value) {
              ob.indexPage(value);
              ob.index = value;
            },
          );
        },
      ),
    );
  }

  void logOut(BuildContext ctx) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

  }
}
