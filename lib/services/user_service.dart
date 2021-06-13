import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EtumedBusiness/models/user.dart';
import 'package:EtumedBusiness/services/services.dart';
import 'package:EtumedBusiness/utils/firebase.dart';

class UserService extends Service {
  String currentUid() {
    return firebaseAuth.currentUser.uid;
  }

  setUserStatus(bool isOnline) {
    var user = firebaseAuth.currentUser;
    if (user != null) {
      usersRef
          .doc(user.uid)
          .update({'isOnline': isOnline, 'lastSeen': Timestamp.now()});
    }
  }

  updateProfile(
      {File image, String username, String bio, String country, String email, String location, String occupation, String department}) async {
    DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    var users = UserModel.fromJson(doc.data());
    users?.username = username;
    users?.bio = bio;
    users?.country = country;
    users?.email=email;
    users?.location = location;
    users?.occupation = occupation;
    users?.department = department;
    if (image != null) {
      users?.photoUrl = await uploadImage(profilePic, image);
    }
    await usersRef.doc(currentUid()).update({
      'username': username,
      'bio': bio,
      'country': country,
      'email': email,
      "photoUrl": users?.photoUrl ?? '',
      'location': location,
      'occupation': occupation,
      'department': department,
    });

    return true;
  }
}