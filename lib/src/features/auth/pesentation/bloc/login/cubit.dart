import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/models/adminModel.dart';
import 'package:store_house/core/services/cache_helper.dart';
 import 'package:store_house/src/features/auth/pesentation/bloc/login/states.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialStates());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  late AdminModel adminModel;

  Future<void> userLogin({required String email, required password}) async {
    emit(AppLoginLoadingStates());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('the nigga token  is ');
      print(value.user?.uid);
      CacheHelper.saveData(key:'token', value: value.user?.uid.toString());
      // adminModel = AdminModel.fromJson(value.user as Map<String, dynamic>);
      emit(AppLoginSuccessStates());
    }).catchError((error) {
      emit(AppLoginErrorStates(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordVisibilityState());
  }
}
