import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class DeleteTransactionUseCase extends UseCaseWithParams<void, String> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture call(String transactionId) async {
    return await _goodsRepository.deleteTransactionDoc(transactionId);
  }
}
