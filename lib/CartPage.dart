

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<MyThemes>(builder: (context, ob, child) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/cart').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
               // ob.counter=docs.length;
                return Card(
                  child: Container(height: 200,

                    child: Column(
                      children: [
                    ListTile(
                    title: Text("${docs[index]["title"]}",
                      overflow: TextOverflow.ellipsis,),
                    trailing: IconButton(
                      icon: Icon(Icons.restore_from_trash_rounded),
                      onPressed: (){
                        FirebaseFirestore.instance.collection('shop/toEgUFd5HJtEsKXKJnjW/cart').doc(docs[index].id).delete();

                      },
                    ),
                    ),
                        Flexible(child: Image.network("${docs[index]["image"]}",)),
                        Container(

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