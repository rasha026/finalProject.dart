

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider.dart';

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Stack(children: <Widget>[

      Container(
        child: Container(
          color:  Colors.white,
          child: Consumer<MyThemes>(builder: (context, ob, child) {
            return  Flexible(
              flex:1,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      child: Container(
                        width: double.infinity,
                          color:Colors.white,
                          child: Container(child: Image.network(ob.album.image,)))),

                  Flexible(
                    child: ClipRRect(
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight: const Radius.circular(40.0),
                      ),
                      child: Container(
                        width:double.infinity ,
                        height: double.infinity,

                        color:ob.backGroundColor,
                        child:Scrollbar(
                          child: ListView(
                            padding: const EdgeInsets.all(15),
                            children: [
                              SizedBox(height: 25,),

                              Card(
                                child: Container(
                                  color:ob.backGroundColor,
                                  child: ListTile(
                                    title: Text(" ${ob.album.title}",
                                        style: TextStyle(fontSize: 19,color: ob.textColor,decoration: TextDecoration.none,),),

                                  ),
                                ),
                              ),

                              Card(
                                child: Container(
                                  color:ob.backGroundColor,
                                  child: ListTile(
                                    title:  Text("ID: ${ob.album.id}",
                                        style: TextStyle(fontSize: 17,color: ob.textColor,decoration: TextDecoration.none,)),
                                  ),
                                ),
                              ),
                              Card(

                                child: Container(
                                  color:ob.backGroundColor,
                                  child: ListTile(
                                    title: Text("price:${ob.album.price}",
                                        style: TextStyle(fontSize: 17,color: ob.textColor,decoration: TextDecoration.none,)),
                                  ),
                                ),
                              ),
                              Card(
                                child: Container(
                                  color:ob.backGroundColor,
                                  child: ListTile(
                                    title: Text("category:${ob.album.category}",
                                        style: TextStyle(fontSize: 17,color: ob.textColor,decoration: TextDecoration.none,)),
                                  ),
                                ),
                              ),

                              Card(
                                child: Container(
                                  color:ob.backGroundColor,
                                  child: ListTile(
                                    title: Text("description:${ob.album.description}",
                                        style: TextStyle(fontSize: 17,color: ob.textColor,decoration: TextDecoration.none,),
                                      ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer<MyThemes>(builder: (context, ob, child) {
                    return Align(alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            ob.counter++;
                              FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/cart').add(

                                  {
                                    'id': "${ob.album.id}",
                                    'title':  "${ob.album.title}",
                                    'price':  "${ob.album.price}",
                                    'description':  "${ob.album.description}",
                                    'category': "${ ob.album.category}",
                                    'image':  "${ob.album.image}",
                                 'favorite': false,
                                  });
                              print(ob.album.id);
                              Navigator.pop(context);


                          },
                          child: Text("Add To Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                        ),
                      ),
                    );
                  }),


                ],
              ),
            );}
          ),
        ),
      ),

        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0, //No shadow
          ),),
    ],),);
  }
}
