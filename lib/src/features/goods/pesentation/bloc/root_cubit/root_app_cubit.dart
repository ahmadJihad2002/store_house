import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:store_house/core/utils/app_util.dart';

import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/add_type/add_type_states.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_states.dart';

class RootAppCubit extends Cubit<RootAppStates> {
  RootAppCubit() : super(RootAppInitialStates());
  GoodsRepository goodsRepository = GoodsRepositoriesImp();

  static RootAppCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;

  void changeIndex(int index) {
    screenIndex = index;
    emit(RootAppBottomNavAppBarChangeStates());
  }



}
