// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import './register_page.dart';
import './signin_page.dart';
import './profile.dart';

// Requires that the Firebase Auth emulator is running locally
// e.g via `melos run firebase:emulator`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(AuthExampleApp());
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class AuthExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example App',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: AuthTypeSelector(),
      ),
    );
  }
}

/// Provides a UI to select a authentication type page
class AuthTypeSelector extends StatelessWidget {
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Example App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.person_add,
              backgroundColor: Colors.indigo,
              text: 'Registration',
              onPressed: () => _pushPage(context, RegisterPage()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.verified_user,
              backgroundColor: Colors.orange,
              text: 'Sign In',
              onPressed: () => _pushPage(context, SignInPage()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: SignInButtonBuilder(
              icon: Icons.supervised_user_circle,
              backgroundColor: Colors.green,
              text: 'Profile',
              onPressed: () => _pushPage(context, ProfilePage()),
            ),
          ),
        ],
      ),
    );
  }
}
=======
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


String nameofuser,passwordofuser,emailofuser;

void main(){
  runApp(
      MaterialApp(debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Center(child: Text("ETUMED BUSINESS")),
            flexibleSpace: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.deepPurple],
            ),
          ),),),
          body: Center(
            child: MyApp(),

          ),
        ),
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
TextEditingController namectrl,emailctrl,passctrl;
int idd;

class _MyAppState extends State<MyApp> {

  bool signin = true;
  Map<String, bool> values = {
    'Login with LinkIn Account': false,
  };



  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl = new TextEditingController();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [Colors.lightBlueAccent, Colors.indigo],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child:Image(fit: BoxFit.fitWidth,image: AssetImage('1.jpg'))
            ),
            boxUi(),
          ],
        )

    );
  }

  void changeState(){
    if(signin){
      setState(() {
        signin = false;

      });
    }else
      setState(() {
        signin = true;

      });
  }

  void registerUser() async{


  }

  void userSignIn() async{



  }

  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.indigo : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.indigo : Colors.grey,
                      fontSize: 25.0,fontWeight: FontWeight.bold,
                    ),),
                ),
              ],
            ),

            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blueAccent])
      ),
      child: Column(
        children: <Widget>[
          TextField(cursorColor: Colors.indigo,
            controller: emailctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
                hintText: 'USER ID',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),


          TextField(cursorColor: Colors.indigo,
            controller: passctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.lock,color: Colors.indigo,),
                hintText: 'Password',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),

          SizedBox(height: 10.0,),

          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              ),

              child: Text('Sign In'),
              onPressed:() {
                userSignIn();

              }
              ),

          SizedBox(height: 10.0,),

          ListView(
            shrinkWrap: true, // use it
            children: values.keys.map((String key) {
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                      alignment: Alignment.centerRight,
                    ),
                    child: new Text('Login with LinkedIn'),

                      onPressed: () =>{
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightBlueAccent


                            ),

                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(cursorColor: Colors.indigo,
                                    controller: namectrl,
                                    decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
                                      hintText: 'LinkedIn Email',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
                                  ),

                                  TextField(cursorColor: Colors.indigo,
                                    controller: emailctrl,
                                    decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
                                      hintText: 'LinkedIn Password',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
                                  ),




                                  SizedBox(height: 10.0,),
                                  ElevatedButton(
                                      child: const Text('Login with LinkedIn'),

                                      onPressed: () {

                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      )

                    },

                  ),
                ],
              );

            }).toList(),
          ),
          SizedBox(
            height: 10.0,
          )






        ],
      ),

    );


  }

  Widget signUpUi(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blueAccent])
      ),
      child: Column(
        children: <Widget>[


          TextField(cursorColor: Colors.indigo,
            controller: namectrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
                hintText: 'First Name',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),
          TextField(cursorColor: Colors.indigo,
            controller: emailctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
              hintText: 'Last Name',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),
          TextField(cursorColor: Colors.indigo,
            controller: emailctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
                hintText: 'E-mail',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),

          TextField(cursorColor: Colors.indigo,
            controller: emailctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,color: Colors.indigo,),
              hintText: 'Phone Number',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),


          TextField(cursorColor: Colors.indigo,
            controller: passctrl,
            decoration: InputDecoration(prefixIcon: Icon(Icons.lock,color: Colors.indigo,),
                hintText: 'Password',focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.indigo),),),
          ),

          SizedBox(height: 10.0,),

          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              ),
              child: Text('Sign Up'),
              onPressed:() {
                registerUser();
              }),
        ],

      ),

    );

  }

}
