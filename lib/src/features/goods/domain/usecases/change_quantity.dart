import 'package:dartz/dartz.dart';
import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';



class ChangeQuantityOfUnitUseCase extends UseCaseWithParams<void,UnitModel> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture call(UnitModel params) async {
    return await _goodsRepository.changingQuantityOfUnit(params.id, params.quantity);
  }
}
