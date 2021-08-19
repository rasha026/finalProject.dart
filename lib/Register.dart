import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'ThemeProvider.dart';


class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController  _mail=TextEditingController();
    TextEditingController _name=TextEditingController();
    TextEditingController _password=TextEditingController();
    final auth =FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: _name,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Your Name",
                    icon: Icon(Icons.person,color: Colors.cyan.shade700,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      borderSide: BorderSide(color:Colors.cyan.shade700,),
                    ),
                  )
              ),
              TextField(
                  controller: _mail,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Your Email",
                    icon: Icon(Icons.mail,color: Colors.cyan.shade700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      borderSide: BorderSide(color: Colors.cyan.shade700),
                    ),)
              ),
              TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Your Password",
                    icon: Icon(Icons.lock,color: Colors.cyan.shade700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                      borderSide: BorderSide(color: Colors.cyan.shade700),
                    ),)
              ),
              SizedBox(height: 15,),
              Consumer<MyThemes>(builder: (context, ob, child) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.white) ,
                  ),
                  child: Text("Register",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Provider.of<MyThemes>(context).textColor ,),),
                  onPressed: (){
                    ob.setTextEmail(_mail.text);
                    ob.setTextName(_name.text);
                    ob.setTextPassword(_password.text);

                    auth.createUserWithEmailAndPassword(email: _mail.text, password: _password.text).then((_) =>
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home())),
                    });

                  },);},),
            ]),
      ),
      backgroundColor:Provider.of<MyThemes>(context).backGroundColor ,
    );
  }}
