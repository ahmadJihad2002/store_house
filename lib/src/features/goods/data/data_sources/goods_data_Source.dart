import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';

abstract class GoodsRemoteDataSource {
  Future<List<UnitModel>> getAllGoods();

  Future<List<TransactionModel>> getAllTransactions();

  Future addNewType(UnitParams params);

  Future changingQuantityOfUnit(String unitID, int newQuantity);

  Future deleteUnit(UnitParams params);

  Future editUnit(UnitParams params);

  Future addTransactionDoc(TransactionParams params);
}

class GoodsRemoteDataSourceImp implements GoodsRemoteDataSource {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
  Future addNewType(UnitParams params) async {
    try {
      String id = fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc()
          .id;

      UnitModel unit = UnitModel(
          id: id,
          name: params.name,
          description: params.description,
          image: getImageNameFromPath(params.image),
          price: params.price,
          quantity: params.quantity,
          threshold: params.threshold);

      await uploadImage(
          image: params.image, imageName: getImageNameFromPath(params.image));
      await fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc(id)
          .set(unit.toJson());
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future editUnit(UnitParams params) async {
    try {
      await uploadImage(
          image: params.image, imageName: getImageNameFromPath(params.image));

      UnitModel unit = UnitModel(
          id: params.id!,
          name: params.name,
          description: params.description,
          image: getImageNameFromPath(params.image),
          price: params.price,
          quantity: params.quantity,
      threshold: params.threshold
      );
      await fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc(params.id)
          .update(unit.toJson());
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future deleteUnit(UnitParams params) async {
    try {
      deleteImage(imageName: getImageNameFromPath(params.image));
      await fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('goods')
          .doc(params.id)
          .delete();
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  uploadImage({required File image, required String imageName}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pictures/$imageName');
    UploadTask uploadTask = storageReference.putFile(image);
    print('csd');
    await uploadTask.whenComplete(() {
      print('Image uploaded');
    });
  }

  deleteImage({required String imageName}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('pictures/$imageName');
    storageReference.delete();
  }

  String getImageNameFromPath(File file) {
    String path = file.path;
    // Get the last part of the path, which is the file name
    String imageName = path.split('/').last;
    return imageName;
  }

  @override
  Future addTransactionDoc(TransactionParams params) async {
    try {
      String id = fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('docs')
          .doc()
          .id;

      TransactionModel transaction = TransactionModel(
          id: id,
          units: params.units,
          date: params.date,
          transactionType: params.transactionType,
          description: params.description,
          timeStamp: params.timeStamp);

      await fireStore
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('docs')
          .doc(id)
          .set(transaction.toJson());
    } catch (error, trace) {
      print(trace.toString());
      print(error.toString());
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      List<TransactionModel> transactions = [];
      final querySnapshot = await FirebaseFirestore.instance
          .collection('storehouses')
          // .doc(auth.currentUser!.uid)
          .doc('xscmkmdvoacsmas')
          .collection('docs')
          .get();

      querySnapshot.docs.forEach((element) async {
        print(element.data());

        TransactionModel transaction =
            TransactionModel.formJson(element.data());
        transactions.add(transaction);
      });

      return transactions;
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }
}
