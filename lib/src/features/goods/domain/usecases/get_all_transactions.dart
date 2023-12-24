import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/models/transaction_model.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class GetAllTransactionsUseCase
    extends UseCaseWithoutParams<List<TransactionModel>> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture<List<TransactionModel>> call() async {
    return await _goodsRepository.getAllTransactions();
  }
}
