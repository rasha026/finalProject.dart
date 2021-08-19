

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<MyThemes>(builder: (context, ob, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/favorite').snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final doc = snapshot.data!.docs;
            return ListView.builder(
                padding: const EdgeInsets.all(25),
                itemCount: doc.length,
                itemBuilder: (ctx, index) {
                  ob.counter=doc.length;
                  return Container(height: 200,

                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                                child: Image.network(
                                  "${doc[index]['image']}",
                                  height: 200,
                                  width: 200,
                                ),
                                onTap: () {

                                }),
                          ),
                          ListTile(
                            title: Text(
                              "${doc[index]['title']} ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 17),
                            ),
                            leading: IconButton(
                              icon: Icon(Icons.favorite,color: Colors.red,),
                              onPressed: (){
                                FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/favorite').doc(doc[index].id).update(
                                    {'favorite':false}
                                );

                                FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/favorite').doc(doc[index].id).delete();

                              },
                            ),

                          ),



                        ],
                      ),
                    ),

                  );
                }
            );
          }
      );

    });


  }}