import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/core/utils/app_util.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/usecases/add_transaction.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/goods_cubit/goods_cubit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/transaction_cubit/transaction_states.dart';

import '../../../data/models/transaction_model.dart';
import '../../../domain/usecases/change_quantity.dart';
import '../../../domain/usecases/get_all_transactions.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionInitialStates());
  final AddTransactionUseCase _addTransactionUseCase = AddTransactionUseCase();
  final ChangeQuantityOfUnitUseCase _changeQuantityOfUnitUseCase =
      ChangeQuantityOfUnitUseCase();
  final GetAllTransactionsUseCase _getAllTransactionsUseCase =
      GetAllTransactionsUseCase();

  static TransactionCubit get(context) => BlocProvider.of(context);

  String? selectedDate = AppUtil.selectedDate;

  Future selectDate(BuildContext context) async {
    AppUtil.selectDate(context);
    emit(AppDateBeenSelectedState());
  }

  List<UnitModel> selectedUnits = [];

  void addIncomingUnit(int newQuantity, UnitModel unit) {
    UnitModel incomingUnit = UnitModel.empty();
    incomingUnit.quantity = newQuantity;
    incomingUnit.image = unit.image;
    incomingUnit.name = unit.name;
    incomingUnit.price = unit.price;
    incomingUnit.id = unit.id;

    selectedUnits.add(incomingUnit);
    emit(AppUnitAddedToIncomingState());
  }

  void deleteIncomingUnit(int index) {
    selectedUnits.removeAt(index);
    emit(AppDeleteIncomingUnitState());
  }
  void deleteIncomingUnitById(String unitId) {
    selectedUnits.removeAt(    selectedUnits.indexWhere((element) => element.id==unitId)
    );
    emit(AppDeleteIncomingUnitState());
  }

  void changeQuantityOfUnit(BuildContext context) async {
    emit(AppAddIncomingGoodsLoadingState());
    UnitModel unit = UnitModel.empty();

    // add the current quantity value to new one

    for (int i = 0; i < selectedUnits.length; i++) {
      for (int j = 0; j < context.read<GoodsCubit>().allUnits.length; j++) {
        if (context.read<GoodsCubit>().allUnits[j].id == selectedUnits[i].id) {
          unit.quantity = selectedUnits[i].quantity +
              context.read<GoodsCubit>().allUnits[j].quantity;

          unit.id = selectedUnits[i].id;

          final result = await _changeQuantityOfUnitUseCase(unit);
          result.fold((failure) {
            emit(AppAddIncomingGoodsErrorState(failure.errorMessage));
          }, (r) {});
          // incomingGoods.removeWhere((element) => element.id==unit.id);
          break;
        }
      }
    }
    emit(AppAddIncomingGoodsSuccessState());
    selectedUnits.clear();
  }

  Future<void> sendTransaction(
      {required String date,
      required String description,
      required TransactionType transactionType,
      required String timeStamp}) async {
    emit(SendTransactionLoadingStates());
    print(selectedUnits.toString());
    final result = await _addTransactionUseCase(TransactionParams(
        date: date,
        units: selectedUnits,
        description: description,
        transactionType: transactionType,
        timeStamp: timeStamp));
    result.fold(
        (failure) => emit(SendTransactionErrorStates(failure.errorMessage)),
        (r) {
      emit(SendTransactionSuccessStates());
    });
  }


  List<TransactionModel> transactions = [];

  void getAllTransactions() async {
    emit(GetAllTransactionsLoadingStates());
    final result = await _getAllTransactionsUseCase();
    result.fold(
        (failure) => emit(GetAllTransactionsErrorStates(failure.errorMessage)),
        (r) {
      transactions = r;
      transactions.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      emit(GetAllTransactionsSuccessStates());
    });
  }
}
