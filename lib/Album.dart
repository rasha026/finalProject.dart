

class Album {
  final id;
  final title;
  final price ;
  final description ;
  final category ;
  final image;

  Album({required this.id, required this.title, required this.price, required this.description, required this.category, required this.image } );

  factory Album.fromJson(Map <String,dynamic> parsedJson)
  {
    return Album(id: parsedJson["id"], title: parsedJson["title"], price:parsedJson["price"] , description: parsedJson["description"], category: parsedJson["category"], image: parsedJson["image"]);

  }

}