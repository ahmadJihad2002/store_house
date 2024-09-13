import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_house/core/utils/app_constant.dart';
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

  Future deleteTransactionDoc(String transactionId);
}

class GoodsRemoteDataSourceImp implements GoodsRemoteDataSource {
  final databaseRef = FirebaseFirestore.instance
      .collection('users')
      .doc(AppConstant.token)
      .collection('storeHouses')
      .doc(AppConstant.token);

  final storageRef =
      FirebaseStorage.instance.ref().child('pictures/${AppConstant.token}');

  @override
  Future<List<UnitModel>> getAllGoods() async {
    try {
      List<UnitModel> goods = [];

      final querySnapshot = await databaseRef.collection('goods').get();

      for (var element in querySnapshot.docs) {
        print(element.data());

        // Get the image URL from the image name
        Map<String, dynamic> data = element.data();
        data['image'] =
            await storageRef.child('${element['image']}').getDownloadURL();

        UnitModel unit = UnitModel.fromJson(data, element.id);
        goods.add(unit);
      }
      print('nigga trying to read some real shit ');

      return goods;
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future changingQuantityOfUnit(String unitID, int newQuantity) async {
    try {
      await databaseRef
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
      String id = databaseRef.collection('goods').doc().id;

      UnitModel unit = UnitModel(
          id: id,
          name: params.name!,
          description: params.description!,
          image: getImageNameFromPath(params.image!),
          price: params.price!,
          quantity: params.quantity!,
          threshold: params.threshold);

      await uploadImage(
          image: params.image!, imageName: getImageNameFromPath(params.image!));

      await databaseRef.collection('goods').doc(id).set(unit.toJson());
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future editUnit(UnitParams params) async {
    try {
      File image = params.image!;
      String imageName = getImageNameFromPath(image);
      String currentImage = await getCurrentImageOfUnit(params.id!);

      if (image.path.isNotEmpty) {
        // to delete the old image if the user changed the unit image
        if (currentImage != imageName) {
          deleteImage(imageName: currentImage);
          print('Delete the old image done ');
        }
        await uploadImage(image: image, imageName: imageName);
      }

      UnitModel unit = UnitModel(
          id: params.id!,
          name: params.name!,
          description: params.description!,
          image: image.path.isEmpty ? currentImage : imageName,
          price: params.price!,
          quantity: params.quantity!,
          threshold: params.threshold);

      await databaseRef
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
      await deleteImage(imageName: await getCurrentImageOfUnit(params.id!));
      await databaseRef.collection('goods').doc(params.id!).delete();
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  Future<void> uploadImage(
      {required File image, required String imageName}) async {
    UploadTask uploadTask =  storageRef.child(imageName).putFile(image);
    print('csd');
    await uploadTask.whenComplete(() {
      print('Image uploaded');
    });
  }

  deleteImage({required String imageName}) async {
    await storageRef.child(imageName).delete();
  }

  String getImageNameFromPath(File file) {
    String path = file.path;
    // Get the last part of the path, which is the file name
    String imageName = path.split('/').last;
    return imageName;
  }

  Future<String> getCurrentImageOfUnit(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await databaseRef.collection('goods').doc(id).get();

      if (docSnapshot.exists) {
        return docSnapshot.get('image');
      } else {
        throw FirebaseException(plugin: 'Document does not exist');
      }
    } catch (error) {
      throw FirebaseException(plugin: error.toString());
    }
  }

  @override
  Future addTransactionDoc(TransactionParams params) async {
    try {
      String id = databaseRef.collection('docs').doc().id;

      TransactionModel transaction = TransactionModel(
          id: id,
          units: params.units,
          date: params.date,
          transactionType: params.transactionType,
          description: params.description,
          timeStamp: params.timeStamp);

      await databaseRef.collection('docs').doc(id).set(transaction.toJson());
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

      final querySnapshot = await databaseRef.collection('docs').get();

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

  @override
  Future<void> deleteTransactionDoc(String transactionId) async {
    try {
      await databaseRef.collection('docs').doc(transactionId).delete();

      // await fireStore
      //     .collection('storehouses')
      //     // .doc(auth.currentUser!.uid)
      //     .doc('xscmkmdvoacsmas')
      //     .collection('docs')
      //     .doc(transactionId)
      //     .delete();
    } catch (error, trace) {
      print(trace.toString());
      print(error.toString());
      throw FirebaseException(plugin: error.toString());
    }
  }
}
