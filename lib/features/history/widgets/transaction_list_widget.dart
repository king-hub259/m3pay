import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/features/history/controllers/transaction_history_controller.dart';
import 'package:six_cash/features/history/domain/models/transaction_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/common/widgets/no_data_widget.dart';
import 'package:six_cash/features/history/widgets/history_shimmer_widget.dart';


import 'transaction_history_widget.dart';
class TransactionListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final bool isHome;
  final String? type;
  const TransactionListWidget({super.key, this.scrollController,  this.isHome = false, this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(builder: (transactionHistory){
      List<Transactions> transactionList = transactionHistory.transactionList;

      return  Column(children: [ !transactionHistory.firstLoading ? transactionList.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: isHome && transactionList.length > 5 ? 5 : transactionList.length,
          itemBuilder: (ctx,index){
            return TransactionHistoryWidget(transactions: transactionList[index]);
            },
        ),) : NoDataFoundWidget(fromHome: isHome): const HistoryShimmerWidget(),

        transactionHistory.isLoading ? Center(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        )) : const SizedBox.shrink(),
      ],);

    });
  }
}
