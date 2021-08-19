import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'ThemeProvider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseStorage storage = FirebaseStorage.instance;
    Future<void> _upload(String inputSource) async {
      final picker = ImagePicker();
      PickedFile? pickedImage;
      try {
        pickedImage = await picker.getImage(
            source: inputSource == 'camera'
                ? ImageSource.camera
                : ImageSource.gallery,
            maxWidth: 1920);

        final String fileName = path.basename(pickedImage!.path);
        File imageFile = File(pickedImage.path);

        try {
          // Uploading the selected image with some custom meta data
          await storage.ref(fileName).putFile(
              imageFile,
              SettableMetadata(customMetadata: {
                'uploaded_by': 'A bad guy',
                'description': 'Some description...'
              }));
        } on FirebaseException catch (error) {
          print(error);
        }
      } catch (err) {
        print(err);
      }
    }




    return Scaffold(
      backgroundColor: Provider.of<MyThemes>(context).backGroundColor,

      body: Consumer<MyThemes>(
        builder: (context, ob, child) {
          return Column(

            children: [
              SizedBox(
                height: 30,
              ),




              InkWell(
                child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              Text("Insert New Picture"),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _upload('camera'),
                      icon: Icon(Icons.camera),
                      label: Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () => _upload('gallery'),
                      icon: Icon(Icons.library_add),
                      label: Text('Gallery')),
                ],
              ),
              SizedBox(
                height: 30,
              ),

              Consumer<MyThemes>(
                builder: (context, ob, child) {
                  return TextFormField(
                    initialValue: ob.name,
                    onChanged: (value) {
                      ob.newName = value;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Provider.of<MyThemes>(context).textColor,
                      errorStyle: TextStyle(
                        color: Colors.red,
                        wordSpacing: 5.0,
                      ),
                      labelStyle: TextStyle(
                        color: Provider.of<MyThemes>(context).textColor,
                        letterSpacing: 1.3,
                        decorationColor:
                        Provider.of<MyThemes>(context).textColor,
                      ),
                      labelText: "User Name",
                      hintText: "Your Name",
                      icon: Icon(Icons.person, color: Colors.cyan.shade700),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          borderSide: BorderSide(
                            color: Provider.of<MyThemes>(context).textColor,
                          )),
                    ),
                    style: TextStyle(
                      color: Provider.of<MyThemes>(context).textColor,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      ob.setTextName(ob.newName);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Home()));
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text("Save Changes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),

                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text("cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),

                  ),

                ],
              ),

            ],
          );
        },
      ),
    );
  }
}
