import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EtumedBusiness/auth/login/login.dart';
import 'package:EtumedBusiness/auth/register/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';






class Landing extends StatefulWidget {
  Landing({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  String redirectUrl = "https://www.google.com";
  String clientId = "86y4aqeoqa4ryj"; /// Your linkedin client id
  String clientSecret = "z2N314FU3LoniuVJ"; /// Your linkedin client secret
  Dio dio = Dio();
  Map<String, dynamic> resultslinkedin;



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
            ),
            SizedBox(height: 50,),
            LinkedInButtonStandardWidget(
                onTap: linkedInLogin
            ),
            resultslinkedin != null && resultslinkedin.isNotEmpty
                ? CachedNetworkImage(imageUrl: resultslinkedin["pic_url"])
                : Text(""),
            resultslinkedin != null && resultslinkedin.isNotEmpty
                ? JsonViewerWidget(resultslinkedin)
                : Text("")
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

  linkedInLogin() async{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            LinkedInUserWidget(
              appBar: AppBar(
                title: Text("Sign-in with Linkedin"),
              ),
              redirectUrl: redirectUrl,
              clientId: clientId,
              clientSecret: clientSecret,
                onGetUserProfile: (LinkedInUserModel linkedInUser) async{
                /// This api call retrives profile picture
                Response response = await dio.get(
                    "https://api.linkedin.com/v2/me?projection=(profilePicture(displayImage~:playableStreams))",
                    options: Options(
                        responseType: ResponseType.json,
                        sendTimeout: 60000,
                        receiveTimeout: 60000,
                        headers: {
                          HttpHeaders.authorizationHeader: "Bearer ${linkedInUser.token.accessToken}"
                        }
                    )
                );
                var profilePic = response.data["profilePicture"]["displayImage~"]["elements"][0]["identifiers"][0]["identifier"];

                Map<String, dynamic> postJson = {
                  "email": linkedInUser.email.elements[0].handleDeep.emailAddress,
                  "pic_url": profilePic,
                  "name": linkedInUser.firstName.localized.label + ' ' + linkedInUser.lastName.localized.label,
                };
                setState(() {
                  resultslinkedin = postJson;
                });
                Navigator.of(context).pop();
              },
              catchError: (LinkedInErrorObject error) {
                print('Error description: ${error.description} Error code: ${error.statusCode.toString()}');
              },
            ),
        fullscreenDialog: true,
      ),
    );
  }
}
