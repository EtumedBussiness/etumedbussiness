import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:EtumedBusiness/auth/register/register.dart';
import 'package:EtumedBusiness/components/stream_builder_wrapper.dart';
import 'package:EtumedBusiness/components/stream_grid_wrapper.dart';
import 'package:EtumedBusiness/models/post.dart';
import 'package:EtumedBusiness/models/user.dart';
import 'package:EtumedBusiness/screens/edit_profile.dart';
import 'package:EtumedBusiness/screens/settings.dart';
import 'package:EtumedBusiness/utils/firebase.dart';
import 'package:EtumedBusiness/widgets/post_tiles.dart';
import 'package:EtumedBusiness/widgets/posts_view.dart';

class Profile extends StatefulWidget {
  final profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>  {
  User user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isToggle = true;
  bool isFollowing = false;
  UserModel users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Etumed Business'),
        actions: [
          widget.profileId == firebaseAuth.currentUser.uid
              ? Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  firebaseAuth.signOut();
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (_) => Register()));
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 15.0),
                ),
              ),
            ),
          )
              : SizedBox()
        ],
      ),
      body: StreamBuilder(
        stream: usersRef.doc(widget.profileId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            UserModel user = UserModel.fromJson(snapshot.data.data());
            return SafeArea(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('https://i.ibb.co/1RBt4sf/bg.jpg'),
                              fit: BoxFit.cover)),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: const Alignment(0, 2.5),
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(user?.photoUrl),
                            radius: 60,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      user.username + ' ' + user.country,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(40),
                            1: FixedColumnWidth(85),
                            2: FlexColumnWidth(),
                          },
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                Icon(Icons.location_on, color: Colors.black26,),
                                Text('Location:', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(user.location ?? 'Not defined')
                              ],
                            ),
                            TableRow(children: <Widget>[Text(''),Text(''),Text('')]),
                            TableRow(
                              children: <Widget>[
                                Icon(Icons.account_balance_wallet, color: Colors.black26),
                                Text('Occupation:', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(user.occupation ?? 'Not defined')
                              ],
                            ),
                            TableRow(children: <Widget>[Text(''),Text(''),Text('')]),
                            TableRow(
                              children: <Widget>[
                                Icon(Icons.category, color: Colors.black26),
                                Text('Department:', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(user.department ?? 'Not defined')
                              ],
                            ),
                            TableRow(children: <Widget>[Text(''),Text(''),Text('')]),
                            TableRow(
                              children: <Widget>[
                                Icon(Icons.contact_mail, color: Colors.black26),
                                Text('Contact:', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(user.email ?? 'Not defined')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildProfileButton(user),
                  ],
                ));
          }
          return Container();
        },
      ),
    );
  }

//show the toggling icons "grid" or "list" view.
  buildIcons() {
    if (isToggle) {
      return IconButton(
          icon: Icon(Feather.list),
          onPressed: () {
            setState(() {
              isToggle = false;
            });
          });
    } else if (isToggle == false) {
      return IconButton(
        icon: Icon(Icons.grid_on),
        onPressed: () {
          setState(() {
            isToggle = true;
          });
        },
      );
    }
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              fontFamily: 'Ubuntu-Regular'),
        ),
        SizedBox(height: 3.0),
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Ubuntu-Regular'),
        )
      ],
    );
  }

  buildProfileButton(user) {
    //if isMe then display "edit profile"
    bool isMe = widget.profileId == firebaseAuth.currentUser.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => EditProfile(
                  user: user,
                ),
              ),
            );
          });
      //if you are already following the user then "unfollow"
    }
  }

  buildButton({String text, Function function}) {
    return Center(
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: 40.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor,
                Color(0xff597FDB),
              ],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }



  buildPostView() {
    if (isToggle == true) {
      return buildGridPost();
    } else if (isToggle == false) {
      return buildPosts();
    }
  }

  buildPosts() {
    return StreamBuilderWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      stream: postRef
          .where('ownerId', isEqualTo: widget.profileId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        PostModel posts = PostModel.fromJson(snapshot.data());
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Posts(
            post: posts,
          ),
        );
      },
    );
  }

  buildGridPost() {
    return StreamGridWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: postRef
          .where('ownerId', isEqualTo: widget.profileId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        PostModel posts = PostModel.fromJson(snapshot.data());
        return PostTile(
          post: posts,
        );
      },
    );
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: favUsersRef
          .where('postId', isEqualTo: widget.profileId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot?.data?.docs ?? [];
          return GestureDetector(
            onTap: () {
              if (docs.isEmpty) {
                favUsersRef.add({
                  'userId': currentUserId(),
                  'postId': widget.profileId,
                  'dateCreated': Timestamp.now(),
                });
              } else {
                favUsersRef.doc(docs[0].id).delete();
              }
            },
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                )
              ], color: Colors.white, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  docs.isEmpty
                      ? CupertinoIcons.heart
                      : CupertinoIcons.heart_fill,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}