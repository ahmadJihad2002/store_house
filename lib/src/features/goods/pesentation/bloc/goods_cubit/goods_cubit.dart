import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/usecases/get_all_goods.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_states.dart';

class GoodsCubit extends Cubit<GoodsStates> {
  GoodsCubit() : super(AppGetAllGoodsInitialStates());
  final GetAllGoodsUseCase _getAllGoodsUseCase = GetAllGoodsUseCase();

  static GoodsCubit get(context) => BlocProvider.of(context);

  bool addTransactionMode = false;
  TransactionType? transactionType;

  List<UnitModel> allUnits = [];

  void getAllGoods() async {
    emit(AppGetAllGoodsLoadingStates());
    final result = await _getAllGoodsUseCase();
    result.fold(
        (failure) => emit(AppGetAllGoodsErrorStates(failure.errorMessage)),
        (r) async {
      allUnits = await r;
      print(allUnits.toString());
      // //
      //
      // while (allUnits) {
      //   Future.delayed(const Duration(seconds: 2));
      //   print('empty shit');
      // }
      emit(AppGetAllGoodsSuccessStates());
    });
  }
}
