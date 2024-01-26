import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_house/core/errors/exception.dart';
import 'package:store_house/core/utils/app_constant.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';

abstract class AccountRemoteDataSource {
  Future<UserModel> reg(UserParams params);

  Future<UserModel> getUserInfo(String userId);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserModel> reg(UserParams params) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: params.email, password: params.password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: params.name,
        image: getImageNameFromPath(params.image),
        email: params.email,
      );

      await uploadImage(
          image: params.image, imageName: getImageNameFromPath(params.image));

      await fireStore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(user.toJson());

      return user;
    } catch (error) {
      throw ServerException();
      throw FirebaseException(plugin: error.toString());
    }
  }

  String getImageNameFromPath(File file) {
    String path = file.path;
    // Get the last part of the path, which is the file name
    String imageName = path.split('/').last;
    return imageName;
  }

  uploadImage({required File image, required String imageName}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pictures/${auth.currentUser!.uid}/$imageName');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() {
      print('Image uploaded');
    });
  }

  @override
  Future<UserModel> getUserInfo(String UserId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fireStore.collection('users').doc(UserId).get();
      if (documentSnapshot.exists) {

        Map<String, dynamic> date = documentSnapshot.data()!;

        date['image'] = await FirebaseStorage.instance
            .ref()
            .child('/pictures/${AppConstant.token}/${date['image']}')
            .getDownloadURL();

        return UserModel.fromMap(date);
      } else {
        throw ServerException(error: 'user doc is not found ');
      }
    } catch (error) {
      throw ServerException();
    }
  }
}
