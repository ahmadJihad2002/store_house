import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:store_house/src/features/goods/domain/usecases/add_new_unit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  GoodsRepository goodsRepository = GoodsRepositoriesImp();
  AddNewUnitUseCase addNewUnitUseCase = AddNewUnitUseCase();

  static AppCubit get(context) => BlocProvider.of(context);

  File? image;

  void uploadImage() async {
    // Step #1: Pick Image From Galler.
    await AppUtil.pickImageFromGallery().then((pickedFile) async {
      // Step #2: Check if we actually picked an image. Otherwise -> stop;
      if (pickedFile == null) return;

      // Step #3: Crop earlier selected image
      await AppUtil.cropSelectedImage(pickedFile.path).then((croppedFile) {
        // Step #4: Check if we actually cropped an image. Otherwise -> stop;
        if (croppedFile == null) return;

        image = croppedFile;
        emit(AppSelectImageState());
        print('image been added and crop');
      });
    });
  }

  int quantity = 0;

// changing the quantity if state = true increase, state = false decrease
  void changeQuantity({required bool state}) {
    if (state) {
      quantity += 1;
    } else if (quantity == 0 && !state) {
      emit(AppChangeQuantityErrorState("can not be under 0"));
    } else {
      quantity -= 1;
    }
    emit(AppChangeQuantityState());
  }

  String? selectedDate = AppUtil.selectedDate;

  Future selectDate(BuildContext context) async {
    AppUtil.selectDate(context);
    emit(AppDateBeenSelectedState());
  }

  void addNewType(
      {required String name,
      required String description,
      required File image,
      required int price,
      required int quantity,
      int? threshold}) async {
    emit(AppAddNewTypeLoadingState());
    try {
      await addNewUnitUseCase(UnitParams(
        name: name,
        quantity: quantity,
        description: description,
        image: image,
        price: price,
        threshold: threshold,
      ));

      emit(AppAddNewTypeSuccessState());
    } catch (error, stackTrace) {
      print("Stack trace:\n$stackTrace");

      // Extract and print the line number
      final lineNumber = RegExp(r'#(\d+)').firstMatch(stackTrace.toString());
      if (lineNumber != null) {
        print("Error occurred at line ${lineNumber.group(1)}");
      }
      print(error.toString());
      emit(AppAddNewTypeErrorState(error.toString()));
    }
  }
}
