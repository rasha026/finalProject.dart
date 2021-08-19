import 'dart:io';

import 'package:final_project4/Album.dart';
import 'package:flutter/material.dart';


class MyThemes with ChangeNotifier {
  Color backGroundColor = Colors.blueGrey.shade50;
  Color textColor = Colors.black;
  bool darkModeSelected = false;
  bool selectedAbout = false;
  bool selectedALanguage = false;
  String name = "";
  String password = "";
  String mail = "";
  String searchItem = "";
  late File imageFile;
  int index = 0;
  String newName = "";
  bool isFavourite = false;

  List <int>savFavorite = [];

  int indexItem = 0;
  late Album album;

  bool check = false;


  changSelectedFav() {
    this.isFavourite = !this.isFavourite;
    notifyListeners();
  }


  indexPage(int index) {
    this.index = index;
    notifyListeners();
  }


  setDarkMode() {
    this.darkModeSelected = !darkModeSelected;
    if (!darkModeSelected) {
      this.textColor = Colors.grey.shade800;
      this.backGroundColor = Colors.blueGrey.shade50;
    }
    else {
      this.backGroundColor = Colors.grey.shade800;
      this.textColor = Colors.white;
    }
    notifyListeners();
  }


  changSelectedAbout() {
    this.selectedAbout = !this.selectedAbout;
    notifyListeners();
  }

  changSelectedLanguage() {
    this.selectedALanguage = !this.selectedALanguage;
    notifyListeners();
  }

  setSearchItem(String searchItem) {
    this.searchItem = searchItem;
    notifyListeners();
  }


  setTextName(String name) {
    this.name = name;
    notifyListeners();
  }

  setTextPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  setTextEmail(String mail) {
    this.mail = mail;
    notifyListeners();
  }


  late Album cartAlbum;
  List<Album> cartList = [];

  int counter = 0;
  bool val=false;

  bool funTrueOrFalse(List list, id) {
    if (list.contains(id))
      this.val =true;
    else
      this.val = false;
    notifyListeners();
    return this.val ;
  }


}









