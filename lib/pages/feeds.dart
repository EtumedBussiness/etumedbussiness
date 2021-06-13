import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EtumedBusiness/components/stream_builder_wrapper.dart';
import 'package:EtumedBusiness/models/post.dart';
import 'package:EtumedBusiness/utils/firebase.dart';
import 'package:EtumedBusiness/widgets/userpost.dart';

class Timeline extends StatelessWidget {
  
 final  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      key: scaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container( decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:
            Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [Colors.red, Colors.black],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),),

        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Etumed Business',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        centerTitle: false,

      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          StreamBuilderWrapper(
            shrinkWrap: true,
            stream: postRef.orderBy('timestamp', descending: true).snapshots(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, DocumentSnapshot snapshot) {
              internetChecker();
              PostModel posts = PostModel.fromJson(snapshot.data());
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                //  child: Posts(post: posts),
                child: UserPost(post: posts),
              );
            },
          ),
        ],
      ),
    );
  }

  internetChecker() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == false) {
      showInSnackBar('No Internet Connecton');
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
