import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class DeleteUnitUseCase extends UseCaseWithParams<void, UnitParams> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture call(UnitParams params) async {
    return await _goodsRepository.deleteUnit(params);
  }
}
