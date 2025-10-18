import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/common/widgets/custom_image_widget.dart';
import 'package:six_cash/features/history/domain/models/transaction_model.dart';
import 'package:six_cash/helper/custom_snackbar_helper.dart';
import 'package:six_cash/helper/date_converter_helper.dart';
import 'package:six_cash/helper/price_converter_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';

class TransactionHistoryWidget extends StatelessWidget {
  final Transactions? transactions;
  const TransactionHistoryWidget({super.key, this.transactions});



  @override
  Widget build(BuildContext context) {
    String? userPhone;
    String? userName;
    String? userImage;
    bool isCredit = (transactions?.credit ?? 0) > 0;

    try{

      userPhone = transactions!.transactionType == AppConstants.sendMoney
          ? transactions!.receiver!.phone : transactions!.transactionType == AppConstants.receivedMoney
          ? transactions!.sender!.phone : (transactions!.transactionType == AppConstants.addMoney
          || transactions!.transactionType == 'add_money_bonus')
          ? transactions!.sender!.phone : transactions!.transactionType == AppConstants.cashIn
          ? transactions!.sender!.phone : transactions!.transactionType == AppConstants.withdraw
          ? transactions!.receiver!.phone : transactions!.userInfo!.phone;

      userName = transactions!.transactionType == AppConstants.sendMoney
          ? transactions!.receiver!.name : transactions!.transactionType == AppConstants.receivedMoney
          ? transactions!.sender!.name : (transactions!.transactionType == AppConstants.addMoney
          || transactions!.transactionType == 'add_money_bonus')
          ? transactions!.sender!.name : transactions!.transactionType == AppConstants.cashIn
          ? transactions!.sender!.name : transactions!.transactionType == AppConstants.withdraw
          ? transactions!.receiver!.name : transactions!.userInfo!.name;

      userImage = transactions!.transactionType == AppConstants.sendMoney
          ? transactions!.receiver!.image : transactions!.transactionType == AppConstants.receivedMoney
          ? transactions!.sender!.image : (transactions!.transactionType == AppConstants.addMoney
          || transactions!.transactionType == 'add_money_bonus')
          ? transactions!.sender!.image : transactions!.transactionType == AppConstants.cashIn
          ? transactions!.sender!.image : transactions!.transactionType == AppConstants.withdraw
          ? transactions!.receiver!.image : transactions!.userInfo!.name;

    }catch(e){
     userName = 'no_user'.tr;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
      child: Column(children: [
        Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
          child: Row(children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              const SizedBox(height: Dimensions.paddingSizeSuperExtraSmall),

              Row( children: [
                SizedBox(
                  height: 35,width: 35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomImageWidget(
                      image: userImage ?? "",
                      placeholder: Images.menPlaceHolder,
                    ),
                  ),
                ),

                const SizedBox(width: Dimensions.paddingSizeSmall),

                Column( crossAxisAlignment: CrossAxisAlignment.start , children: [
                  Text(
                    userName ?? '',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: rubikRegular.copyWith(),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSuperExtraSmall),

                  Text(userPhone ?? '', style: rubikLight.copyWith(fontSize: Dimensions.fontSizeDefault)),
                ]),
              ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraSmall),
                  color: Theme.of(context).primaryColor.withValues(alpha:0.05),
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('TrxID:',
                      style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                    ),

                    Text(
                      '${transactions!.transactionId}',
                      style: rubikLight.copyWith(fontSize: Dimensions.fontSizeDefault),
                    )
                  ]),
                  
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: "${transactions!.transactionId}"));
                      showCustomSnackBarHelper('transaction_id_copied'.tr,isError: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeVerySmall),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Icon(Icons.copy_rounded, size: 18, color: Theme.of(context).primaryColor,),
                    ),
                  )
                  
                ]),
              ),

            ]),
            const Spacer(),

            Column( crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                DateConverterHelper.estimatedDate(DateTime.parse(transactions!.createdAt!)),
                style: rubikRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall + 1,
                  color: ColorResources.getHintColor(),
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeSuperExtraSmall),
              Text(
                DateConverterHelper.isoStringToLocalTimeOnly(transactions!.createdAt!),
                style: rubikRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall + 1,
                  color: ColorResources.getHintColor(),
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeDefault),


              Text(
                transactions?.transactionType?.tr ?? "",
                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
              ),
              Text(
                '${isCredit ? '+' : '-'} ${PriceConverterHelper.convertPrice(double.parse(transactions!.amount.toString()))}',
                style: rubikSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: isCredit ? Colors.green : Colors.redAccent,
                ),
              ),
            ]),

          ]),
        ),
        const SizedBox(height: 5),

        Divider(thickness: 0.4, color: Theme.of(context).hintColor.withValues(alpha:0.3)),
      ]),
    );
  }
}

