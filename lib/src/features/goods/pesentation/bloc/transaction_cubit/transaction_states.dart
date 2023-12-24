abstract class TransactionStates {}

class TransactionInitialStates extends TransactionStates {}
class AppDateBeenSelectedState extends TransactionStates {}

class SendTransactionLoadingStates extends TransactionStates {}

class SendTransactionSuccessStates extends TransactionStates {}

class SendTransactionErrorStates extends TransactionStates {
  final String error;

  SendTransactionErrorStates(this.error);
}

class GetAllTransactionsLoadingStates extends TransactionStates {}

class GetAllTransactionsSuccessStates extends TransactionStates {}

class GetAllTransactionsErrorStates extends TransactionStates {
  final String error;

  GetAllTransactionsErrorStates(this.error);
}

class DeleteTransactionsSuccessStates extends TransactionStates {}

class DeleteTransactionsLoadingStates extends TransactionStates {}

class DeleteTransactionsErrorStates extends TransactionStates {
  final String error;

  DeleteTransactionsErrorStates(this.error);
}

class AppUnitAddedToIncomingState extends TransactionStates {}

class AppDeleteIncomingUnitState extends TransactionStates {}

class AppAddIncomingGoodsSuccessState extends TransactionStates {}

class AppAddIncomingGoodsLoadingState extends TransactionStates {}

class AppAddIncomingGoodsErrorState extends TransactionStates {
  final String error;

  AppAddIncomingGoodsErrorState(this.error);
}
