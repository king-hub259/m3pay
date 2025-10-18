import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/features/history/domain/models/transaction_model.dart';
import 'package:six_cash/features/history/domain/reposotories/transaction_history_repo.dart';
import 'package:get/get.dart';

class TransactionHistoryController extends GetxController implements GetxService{
  final TransactionHistoryRepo transactionHistoryRepo;
  TransactionHistoryController({required this.transactionHistoryRepo});

  int? _pageSize;
  bool _isLoading = false;
  bool _firstLoading = true;
  bool get firstLoading => _firstLoading;
  int _offset = 1;
  int get offset =>_offset;
  int _transactionTypeIndex = 0;

  List<Transactions> _transactionList  = [];
  List<Transactions> get transactionList => _transactionList;

  List<Transactions> _allTransactionList  = [];
  List<Transactions> get allTransactionList=> _allTransactionList;

  TransactionModel? _transactionModel;
  TransactionModel? get transactionModel => _transactionModel;

  List<String> transactionType = ['all', 'send_money',  'cash_in', 'add_money', 'received_money', 'cash_out', 'withdraw','payment'];



  int? get pageSize => _pageSize;
  bool get isLoading => _isLoading;
  int get transactionTypeIndex => _transactionTypeIndex;

  void showBottomLoader() {
    _isLoading = true;
    update();
  }


  Future getTransactionData(int offset, {bool reload = false, String transactionType = "all"}) async{
    if(reload) {
      _transactionList = [];
      if(transactionType =="all"){
        _allTransactionList = [];
      }
      _transactionModel = null;
    }
    _offset = offset;

    Response response = await transactionHistoryRepo.getTransactionHistory(offset, transactionType: transactionType);

    if(response.body['transactions'] != null && response.body['transactions'] != {} && response.statusCode==200){
      _transactionModel =  TransactionModel.fromJson(response.body);

      if(offset ==1){
        _transactionList = [];
        _transactionList.addAll(_transactionModel?.transactions ?? []);

        if(transactionType == "all"){
          _allTransactionList = [];
          _allTransactionList.addAll(_transactionModel?.transactions ?? []);
        }
      }else{
        _transactionList.addAll(_transactionModel?.transactions ?? []);
        if(transactionType == "all"){
          _allTransactionList.addAll(_transactionModel?.transactions ?? []);
        }
      }
    }else{
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    _firstLoading = false;
    update();


  }

  void setIndex(int index, {bool reload = true}) {
    _transactionTypeIndex = index;
    if(reload){
      update();
    }
  }

}