import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:six_cash/common/widgets/custom_app_bar_widget.dart';
import 'package:six_cash/common/widgets/no_data_widget.dart';
import 'package:six_cash/common/widgets/paginated_list_widget.dart';
import 'package:six_cash/features/history/controllers/transaction_history_controller.dart';
import 'package:six_cash/features/history/domain/models/transaction_model.dart';
import 'package:six_cash/features/history/widgets/history_shimmer_widget.dart';
import 'package:six_cash/features/history/widgets/transaction_history_widget.dart';
import 'package:six_cash/features/history/widgets/transaction_type_button_widget.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  final Transactions? transactions;
  const HistoryScreen({super.key, this.transactions});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  AutoScrollController? _tabScrollController;
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _tabScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.horizontal,
    );
    Get.find<TransactionHistoryController>().getTransactionData(1, transactionType: "all");
    Get.find<TransactionHistoryController>().setIndex(0);
    _tabScrollController?.scrollToIndex(0);
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: CustomAppbarWidget(title: 'history'.tr, onlyTitle: true),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final controller = Get.find<TransactionHistoryController>();
            await Get.find<TransactionHistoryController>().getTransactionData(1,reload: true,
              transactionType: controller.transactionType[controller.transactionTypeIndex],
            );
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
            controller: _scrollController, slivers: [

              SliverPersistentHeader(pinned: true, delegate: SliverDelegate(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  height: 50, alignment: Alignment.centerLeft,
                  color: Theme.of(context).cardColor,
                  child: GetBuilder<TransactionHistoryController>( builder: (historyController){
                    return ListView(
                      controller: _tabScrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      scrollDirection: Axis.horizontal,
                      children: historyController.transactionType.map((element) {
                        int index =  historyController.transactionType.indexOf(element);
                        return  AutoScrollTag(
                          key: ValueKey(index),
                          controller: _tabScrollController!,
                          index: index,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TransactionTypeButtonWidget(
                              text: element.tr, index: index,
                              onTap: (){
                                historyController.setIndex(index);
                                _tabScrollController?.scrollToIndex(index);
                                historyController.getTransactionData(1, transactionType: element, reload: index !=0);
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              )),

              SliverToBoxAdapter(
                child: GetBuilder<TransactionHistoryController>(builder: (historyController){

                  List<Transactions> transactions = historyController.transactionType[historyController.transactionTypeIndex] == "all"
                      ? historyController.allTransactionList : historyController.transactionList;

                  return historyController.transactionModel !=null ? PaginatedListWidget(
                    scrollController: _scrollController,
                    totalSize: historyController.transactionModel?.totalSize,
                    onPaginate: (int offset) async => await historyController.getTransactionData(
                      offset, transactionType: historyController.transactionType[historyController.transactionTypeIndex]
                    ),
                    offset: historyController.transactionModel?.offset,
                    itemView:  transactions.isNotEmpty ?  ListView.builder(
                      itemCount:  transactions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      itemBuilder: (context, index) {
                        return TransactionHistoryWidget(transactions: transactions [index]);
                      },
                    ) : const NoDataFoundWidget(fromHome: false),

                  ) : const HistoryShimmerWidget();
                }),
              ),


            ],
          ),
        ),
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}