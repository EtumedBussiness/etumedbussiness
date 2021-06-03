import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:EtumedBusiness/models/user.dart';
import 'package:EtumedBusiness/services/user_service.dart';
import 'package:EtumedBusiness/utils/constants.dart';

class EditProfileViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  UserService userService = UserService();
  final picker = ImagePicker();
  UserModel user;
  String country;
  String username;
  String email;
  String bio;
  String location;
  String occupation;
  String department;
  File image;
  String imgLink;

  setUser(UserModel val) {
    user = val;
    notifyListeners();
  }

  setImage(UserModel user) {
    imgLink = user.photoUrl;
  }

  setCountry(String val) {
    print('SetCountry $val');
    country = val;
    notifyListeners();
  }

  setLocation(String val) {
    print('SetLocation $val');
    location = val;
    notifyListeners();
  }

  setOccupation(String val) {
    print('SetOccupation $val');
    occupation = val;
    notifyListeners();
  }

  setDepartment(String val) {
    print('setDepartment $val');
    department = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio$val');
    bio = val;
    notifyListeners();
  }

  setUsername(String val) {
    print('SetUsername $val');
    username = val;
    notifyListeners();
  }
  setemail(String val) {
    print('SetEmail $val');
    email = val;
    notifyListeners();
  }

  editProfile(BuildContext context) async {
    FormState form = formKey.currentState;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      try {
        loading = true;
        notifyListeners();
        bool success = await userService.updateProfile(
        //  user: user,
          image: image,
          username: username,
          occupation: this.occupation,
          country: country,
          email: email,
          location: location,
          department: department,
        );
        print(success);
        if (success) {
          clear();
          Navigator.pop(context);
        }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
      }
      loading = false;
      notifyListeners();
    }
  }

  pickImage({bool camera = false}) async {
    loading = true;
    notifyListeners();
    try {
      PickedFile pickedFile = await picker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Constants.lightAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      image = File(croppedFile.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled');
    }
  }

  clear() {
    image = null;
    notifyListeners();
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
