
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class TransactionHistoryRepo{
  final ApiClient apiClient;

  TransactionHistoryRepo({required this.apiClient});

  Future<Response> getTransactionHistory(int offset, {String? transactionType}) async {
    return await apiClient.getData('${AppConstants.customerTransactionHistory}?transaction_type=$transactionType&limit=10&offset=$offset');
  }
}