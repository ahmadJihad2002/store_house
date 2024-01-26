import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/services/cache_helper.dart';
import 'package:store_house/core/utils/app_constant.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/auth/domain/entities/user.dart';
import 'package:store_house/src/features/auth/domain/usecases/login.dart';
import 'package:store_house/src/features/auth/pesentation/bloc/login/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(AppLoginInitialStates());
  LoginUseCase loginUseCase = LoginUseCase();

  static LoginCubit get(context) => BlocProvider.of(context);
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

  void login(
      {required String email,
      required String password,
      required File image,
      required String name}) async {
    emit(AppLoginLoadingStates());

    final result = await loginUseCase(
        UserParams(name: name, image: image, email: email, password: password));
    result.fold((failure) => emit(AppLoginErrorStates(failure.errorMessage)),
        (r) async {
      String userId = r;
      AppConstant.token=r;
      await CacheHelper.saveData(key: 'token', value: userId);

      emit(AppLoginSuccessStates());
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
