import 'package:store_house/core/utils/typedef.dart';
import 'package:store_house/core/utils/usecase.dart';
import 'package:store_house/src/features/goods/data/models/unit_model.dart';
import 'package:store_house/src/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:store_house/src/features/goods/domain/entities/transaction.dart';
import 'package:store_house/src/features/goods/domain/entities/unit.dart';
import 'package:store_house/src/features/goods/domain/repositories/goods_repository.dart';

class AddTransactionUseCase extends UseCaseWithParams<void, TransactionParams> {
  final GoodsRepository _goodsRepository = GoodsRepositoriesImp();

  @override
  ResultFuture call(TransactionParams params) async {
    return await _goodsRepository.addTransactionDoc(params);
  }
}
