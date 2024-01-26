import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/root_cubit/root_app_states.dart';

class RootAppCubit extends Cubit<RootAppStates> {
  RootAppCubit() : super(RootAppInitialStates());
  GoodsRepository goodsRepository = GoodsRepositoriesImp();

  static RootAppCubit get(context) => BlocProvider.of(context);

   bool isConnected =  false;

  Future<void> init() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isInternetConnected(result);
    });
  }

  bool isInternetConnected(ConnectivityResult? result) {
    if (result == ConnectivityResult.none) {
      isConnected  = false;
      emit(ChangeConnectionState());
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isConnected  = true;
      emit(ChangeConnectionState());

      return true;
    }
    emit(ChangeConnectionState());

    return false;
  }

  int screenIndex = 0;

  void changeIndex(int index) {
    screenIndex = index;
    emit(RootAppBottomNavAppBarChangeStates());
  }
}
