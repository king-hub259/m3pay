
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/features/home/domain/models/global_key_manager_model.dart';
import 'package:six_cash/features/splash/controllers/splash_controller.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/features/home/widgets/banner_widget.dart';
import 'package:six_cash/features/home/widgets/option_card_widget.dart';
import 'package:six_cash/features/transaction_money/screens/transaction_balance_input_screen.dart';
import 'package:six_cash/features/transaction_money/screens/transaction_money_screen.dart';

class ThemeTwoWidget extends StatelessWidget {
  final GlobalKeyManagerModel keyManager;
  final GlobalKey? lastKey;
  const ThemeTwoWidget({super.key, required this.keyManager, this.lastKey});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Stack(children: [
          Container(height: 75, color: Theme.of(context).primaryColor),

          Positioned(child: Column(children: [


            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  if(splashController.configModel!.systemFeature!.sendMoneyStatus!) Expanded(
                    child: OptionCardWidget(
                      showcaseTitle: 'from_here_you_can_send_your_money',
                      showcaseKey: keyManager.sendMoneyKey,
                      isDone: lastKey == keyManager.sendMoneyKey,
                      image: Images.sendMoneyLogo,
                      text: 'send_money'.tr,
                      color: Theme.of(context).secondaryHeaderColor,
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'send_money'));
                      },
                    ),
                  ),

                  if(splashController.configModel!.systemFeature!.cashOutStatus!) Expanded(
                    child: OptionCardWidget(
                      showcaseTitle: "from_here_you_can_cash_out",
                      showcaseKey: keyManager.cashOutKey,
                      isDone: lastKey == keyManager.cashOutKey,
                      image: Images.cashOutLogo,
                      text: 'cash_out'.tr,
                      color: ColorResources.getCashOutCardColor(),
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'cash_out'));
                      },
                    ),
                  ),

                  if(splashController.configModel!.systemFeature!.addMoneyStatus!)Expanded(
                    child: OptionCardWidget(
                      showcaseKey: keyManager.addMoneyKey,
                      isDone: lastKey == keyManager.addMoneyKey,
                      showcaseTitle: "from_here_you_can_add_money_to_your_account",
                      image: Images.walletLogo,
                      text: 'add_money'.tr,
                      color: ColorResources.getAddMoneyCardColor(),
                      onTap: () => Get.to(const TransactionBalanceInputScreen(
                        transactionType: TransactionType.addMoney,
                      )),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall),
              child: Row(
                children: [
                  if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!) Expanded(
                    child: OptionCardWidget(
                      showcaseKey: keyManager.requestMoneyKey,
                      isDone: lastKey == keyManager.requestMoneyKey,
                      showcaseTitle: "from_here_you_can_request_money",
                      image: Images.requestMoney3,
                      text: 'request_money'.tr,
                      color: ColorResources.getRequestMoneyCardColor(),
                      onTap: () {
                        Get.to(()=> const TransactionMoneyScreen(fromEdit: false,transactionType: 'request_money'));
                      },
                    ),
                  ),


                ],
              ),
            ),
            /// Banner..
            const BannerWidget(),
          ],
          )),
        ]);
      }
    );
  }

}
