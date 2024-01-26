import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class GetAllGoodsUseCase extends UseCaseWithoutParams<List<UnitModel>> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture<List<UnitModel>> call() async {
    return await _goodsRepository.getAllGoods();
  }
}
