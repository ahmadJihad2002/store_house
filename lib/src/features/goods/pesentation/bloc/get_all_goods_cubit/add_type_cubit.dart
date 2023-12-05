import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_house/core/utils/app_util.dart';

import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:store_house/src/features/goods/domain/usecases/get_all_goods.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/get_all_goods_cubit/add_type_states.dart';

class GetALLGoodsCubit extends Cubit<AppGetAllCubitStates> {
  GetALLGoodsCubit() : super(AppGetAllGoodsInitialStates());
  GoodsRepository goodsRepository = GoodsRepositoriesImp();
  GetAllGoodsUseCase getAllGoodsUseCase = GetAllGoodsUseCase();

  static GetALLGoodsCubit get(context) => BlocProvider.of(context);
  List<UnitModel> allUnits = [];

  void getAllGoods() async {
    emit(AppGetAllGoodsLoadingStates());

    final result = await getAllGoodsUseCase();
    result.fold(
        (failure) => emit(AppGetAllGoodsErrorStates(failure.errorMessage)),
        (r) {
      allUnits = r;
      emit(AppGetAllGoodsSuccessStates(r));
    });
  }
}
