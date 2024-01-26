import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_constant.dart';
import 'package:store_house/src/features/account/data/models/user_model.dart';
import 'package:store_house/src/features/account/domain/usecases/get_userInfo.dart';
import 'package:store_house/src/features/account/presentation/bloc/account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(AccountInitialStates());
  GetUserInfoUseCase getUserInfoUseCase = GetUserInfoUseCase();

  static AccountCubit get(context) => BlocProvider.of(context);

    UserModel user= UserModel.empty();

  void getUserInfo() async {
    emit(GetAccountInfoLoadingState());
    final result = await getUserInfoUseCase.call(AppConstant.token);
    result.fold(
        (failure) => emit(GetAccountInfoErrorState(failure.errorMessage)), (r) {
      user = r;
      emit(GetAccountInfoSuccessState());
    });
  }


  void editUserInfo() async {
    emit(GetAccountInfoLoadingState());
    final result = await getUserInfoUseCase.call(AppConstant.token);
    result.fold(
            (failure) => emit(GetAccountInfoErrorState(failure.errorMessage)), (r) {
      user = r;
      emit(GetAccountInfoSuccessState());
    });
  }
}
