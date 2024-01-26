import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/usecases/deleteUnit.dart';
import 'package:store_house/src/features/goods/domain/usecases/edit_unit.dart';
import 'package:store_house/src/features/goods/pesentation/bloc/edit_cubit/edit_states.dart';

class EditUnitCubit extends Cubit<EditUnitStates> {
  EditUnitCubit() : super(EditInitialState());

  // GoodsRepository _goodsRepository = GoodsRepositoriesImp();
  final EditUnitUseCase _editUnitUseCase = EditUnitUseCase();
  final DeleteUnitUseCase _deleteUnitUseCase = DeleteUnitUseCase();

  static EditUnitCubit get(context) => BlocProvider.of(context);

  void deleteUnit({required String id}) async {
    emit(DeleteUnitLoadingState());
    UnitParams params = UnitParams(id: id);
    final result = await _deleteUnitUseCase(params);
    result.fold((failure) => emit(DeleteUnitErrorState(failure.errorMessage)),
        (r) {
      emit(DeleteUnitSuccessState());
    });
  }

  void editUnit({
    required String id,
    required String name,
    required String description,
    required File? image,
    required int price,
    required int quantity,
    required int threshold,
  }) async {
    emit(EditUnitLoadingState());

    UnitParams params = UnitParams(
        threshold: threshold,
        id: id,
        name: name,
        quantity: quantity,
        description: description,
        image: image ?? File(''),
        price: price);

    final result = await _editUnitUseCase(params);
    result.fold((failure) => emit(EditUnitErrorState(failure.errorMessage)),
        (r) {
      emit(EditUnitSuccessState());
    });
  }

  int quantity = 0;

// changing the quantity if state = true increase, state = false decrease
  void changeQuantity({required bool state}) {
    if (state) {
      quantity += 1;
    } else if (quantity == 0 && !state) {
      emit(EditChangeQuantityErrorState("can not be under 0"));
    } else {
      quantity -= 1;
    }
    emit(EditChangeQuantitySuccessState());
  }
}
