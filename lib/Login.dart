import 'package:flutter/material.dart';
import 'package:final_project4/Register.dart';
import 'Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _mail = TextEditingController();
    TextEditingController _password = TextEditingController();
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Provider.of<MyThemes>(context).backGroundColor,
      appBar: AppBar(
        backgroundColor: Provider.of<MyThemes>(context).backGroundColor,
        title: Text("Log in"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.black,
                    ))),
            Padding(
                padding: EdgeInsets.all(20),
                child: Consumer<MyThemes>(builder: (context, ob, child) {
                  return TextFormField(
                    autofocus: false,
                    validator: (input) =>
                        !input!.contains('@') ? 'Not a Valid Email' : null,
                    onSaved: (input) => ob.mail = input!,
                    controller: _mail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Provider.of<MyThemes>(context).textColor,
                      errorStyle: TextStyle(
                        color: Colors.red,
                        wordSpacing: 5.0,
                      ),
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                          color: Provider.of<MyThemes>(context).textColor,
                          letterSpacing: 1.3),
                      hintText: "Your Email",
                      icon: Icon(
                        Icons.mail,
                        color: Colors.cyan.shade700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                        borderSide: BorderSide(
                          color: Provider.of<MyThemes>(context).textColor,
                        ),
                      ),
                    ),
                    style:  TextStyle(color: Provider.of<MyThemes>(context).textColor,),
                  );
                })),
            Padding(
                padding: EdgeInsets.all(20),
                child: Consumer<MyThemes>(
                  builder: (context, ob, child) {
                    return TextFormField(
                      autofocus: false,
                      validator: (input) =>
                          input!.isEmpty ? 'Not a Valid password' : null,
                      onSaved: (input) => ob.name = input!,
                      controller: _password,
                      obscureText: true,
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
                        labelText: "Password",
                        hintText: "Your Password",
                        icon: Icon(Icons.lock, color: Colors.cyan.shade700),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            borderSide: BorderSide(
                              color: Provider.of<MyThemes>(context).textColor,
                            )),
                      ), style:  TextStyle(color: Provider.of<MyThemes>(context).textColor,),
                    );
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                ),
                Consumer<MyThemes>(builder: (context, ob, child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      ob.setTextEmail(_mail.text);
                      ob.setTextPassword(_password.text);

                       auth.signInWithEmailAndPassword(email: _mail.text, password: _password.text).then((_) =>
                      {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home())),
                      }
                      );
                    },
                    child: Text("Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
