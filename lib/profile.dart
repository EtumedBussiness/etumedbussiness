import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import './edit_profile.dart';

/// Entrypoint example for various sign-in flows with Firebase.
class ProfilePage extends StatefulWidget {
  /// The page title.
  final String title = 'Edit & View Your Profile';

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.ibb.co/1RBt4sf/bg.jpg"
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0,2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.ibb.co/N7vn6QZ/indir.jpg"
                    ),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Mesut Ozil",
              style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Istanbul, Turkey",
              style: TextStyle(
                  fontSize: 18.0,
                  color:Colors.white70,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Software Developer at SuperGame LLC.",
              style: TextStyle(
                  fontSize: 15.0,
                  color:Colors.white60,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Project",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("15",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                      Column(
                        children: [
                          Text("Followers",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("2000",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: (){
                _pushPage(context, EditProfilePage());
              },
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: Ink(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
