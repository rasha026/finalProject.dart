import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project4/CartPage.dart';
import 'package:final_project4/FavoritePage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Album.dart';

import 'Http.dart';
import 'Item.dart';
import 'ThemeProvider.dart';


class ListStructure extends StatefulWidget {
  const ListStructure({Key? key}) : super(key: key);

  @override
  State<ListStructure> createState() => _ListStructureState();
}

class _ListStructureState extends State<ListStructure> {
  @override
  Widget build(BuildContext context) {
 


    late Future<List<Album>> user;
    Http obj = new Http();
    user = obj.getData();

    return Consumer<MyThemes>(builder: (context, ob, child) {
      return FutureBuilder<List<Album>>(
        future: user,

            builder: (context, snapshot) {
              if (ob.index == 0) {
            if (snapshot.hasData) {
              return GridView.count(
                childAspectRatio: 1 / 1.6,
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                children: List.generate(
                  snapshot.data!.length,
                  (index) => Container(
                    decoration: BoxDecoration(),
                    child: Card(
                      color: Colors.white,


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: InkWell(
                                child: Image.network(
                                  "${snapshot.data![index].image}",
                                  height: 200,
                                  width: 200,
                                ),
                                onTap: () {
                                  ob.album = snapshot.data![index];
                                  ob.indexItem = index;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Item(),
                                      ));
                                }),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${snapshot.data![index].title} ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${snapshot.data![index].price} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17),
                                  )),

                              funcIcon(context,index,snapshot.data!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          else if(ob.index==2)
            return CartPage();
          else if(ob.index==1){
            return FavoritePage();
          }
          return CircularProgressIndicator();
        },
      );
    });
  }



  funcIcon(BuildContext context, int index, List<Album> list) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Consumer<MyThemes>(
          builder: (context, ob, child) {
            return Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(
                    'shop/toEgUFd5HJtEsKXKJnjW/favorite').snapshots(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  final docs = snapShot.data!.docs;

                  return IconButton(
                      icon: Icon(Icons.favorite
                      ),
                      color:ob.funTrueOrFalse(ob.savFavorite,list[index].id)?Colors.red:Colors.grey,
                      onPressed: () {

                       if(!ob.savFavorite.contains(list[index].id))
                       {print("true");
                       ob.savFavorite.add(list[index].id);
                         FirebaseFirestore.instance
                             .collection(
                             'shop/toEgUFd5HJtEsKXKJnjW/favorite').add({
                           'id': list[index].id,
                           'title': list[index].title,
                           'price': list[index].price,
                           'description': list[index].description,
                           'category': list[index].category,
                           'image': list[index].image,
                           'favorite': true,

                         });
                       }

                        else
                          {
                          FirebaseFirestore.instance.collection(
                              'shop/toEgUFd5HJtEsKXKJnjW/favorite').doc(
                              docs[index].id).update(
                              {'favorite': false}
                          );
                          FirebaseFirestore.instance.collection(
                              'shop/toEgUFd5HJtEsKXKJnjW/favorite').doc(
                              docs[index].id).delete();
                          ob.savFavorite.add(list[index].id);
                          print("falseeeeeeee");

                        }





                      }


                  );
                },


              ),
            );
          }
      ),
    );
  }
  

    
    
  }











