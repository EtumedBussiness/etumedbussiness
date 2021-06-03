import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EtumedBusiness/auth/login/login.dart';
import 'package:EtumedBusiness/auth/register/register.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [Colors.red, Colors.black],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  'assets/etu_med_logo.png',
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'ETUMED BUSINESS',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Ubuntu-Regular',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(



        elevation: 0.0,
        child: Container(

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.0, 0), // 10% of the width, so there are ten blinds.
              colors: [Colors.red, Colors.black],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0, bottom: 20.0,top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (_) => Login(),
                      ),
                    );
                  },
                  child: Container(
                    height: 45.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Colors.grey),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Theme.of(context).accentColor,
                          Color(0xffc62828),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(builder: (_) => Register()));
                  },
                  child: Container(
                    height: 45.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Colors.white),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Theme.of(context).accentColor,
                          Color(0xffc62828),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
