import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';

abstract class GoodsRemoteDataSource {
  Future<List<UnitModel>> getAllGoods();

  Future addNewType({
    required String id,
    required String name,
    required String description,
    required File image,
    required double price,
    required int quantity,
  });

  Future changingQuantityOfUnit(String unitID, int newQuantity);

  Future uploadImage({required File image, required String imageName});
}

class GoodsRemoteDataSourceImp implements GoodsRemoteDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  GoodsRemoteDataSourceImp();

  @override
  Future<List<UnitModel>> getAllGoods() async {
    try {
      List<UnitModel> goods = [];
      final querySnapshot = await FirebaseFirestore.instance
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .get();

      querySnapshot.docs.forEach((element) async {
        print(element.data());
        // get the image url from image name
        Map<String, dynamic> data = element.data();
        data['image'] = await FirebaseStorage.instance
            .ref()
            .child('/pictures/${element['image']}')
            .getDownloadURL();

        UnitModel unit = UnitModel.fromJson(data, element.id);
        goods.add(unit);
      });

      print('nigga trying to read some real shit ');

      return goods;
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future changingQuantityOfUnit(String unitID, int newQuantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('storehouses')
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc(unitID)
          .update({'quantity': newQuantity});
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future addNewType(
      {required String id,
      required String name,
      required String description,
      required File image,
      required double price,
      required int quantity}) async {
    try {
      UnitModel unit = UnitModel(
          id: id,
          name: name,
          description: description,
          image: getImageNameFromPath(image),
          price: price,
          quantity: quantity);

      await uploadImage(image: image, imageName: getImageNameFromPath(image));
      await fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc()
          .set(unit.toJson());
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  uploadImage({required File image, required String imageName}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pictures/$imageName');
    UploadTask uploadTask = storageReference.putFile(image);
    print('csd');
    await uploadTask.whenComplete(() {
      print('Image uploaded');
    });
  }

  String getImageNameFromPath(File file) {
    String path = file.path;
    // Get the last part of the path, which is the file name
    String imageName = path.split('/').last;
    return imageName;
  }
}
