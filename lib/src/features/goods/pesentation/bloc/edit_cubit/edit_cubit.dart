import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:store_house/src/features/goods/domain/usecases/edit_unit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/edit_cubit/edit_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_states.dart';

class EditUnitCubit extends Cubit<EditUnitStates> {
  EditUnitCubit() : super(EditInitialState());
  GoodsRepository goodsRepository = GoodsRepositoriesImp();
  EditUnitUseCase editUnitUseCase = EditUnitUseCase();

  static EditUnitCubit get(context) => BlocProvider.of(context);

  void editUnit(
      {required String id,
      required String name,
      required String description,
      required File image,
      required int price,
      required int quantity}) async {
    emit(EditUnitLoadingState());

    UnitParams params = UnitParams(
        id: id,
        name: name,
        quantity: quantity,
        description: description,
        image: image,
        price: price);

    final result = await editUnitUseCase(params);
    result.fold((failure) => emit(EditUnitErrorState(failure.errorMessage)),
        (r) {
      emit(EditUnitSuccessState());
    });
  }
}
