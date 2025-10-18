import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/common/widgets/custom_showcase_widget.dart';
import 'package:six_cash/features/home/domain/models/global_key_manager_model.dart';
import 'package:six_cash/features/setting/controllers/profile_screen_controller.dart';
import 'package:six_cash/features/splash/controllers/splash_controller.dart';
import 'package:six_cash/helper/price_converter_helper.dart';
import 'package:six_cash/helper/transaction_type.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/common/widgets/custom_ink_well_widget.dart';
import 'package:six_cash/features/home/widgets/banner_widget.dart';
import 'package:six_cash/features/home/widgets/option_card_widget.dart';
import 'package:six_cash/features/requested_money/screens/requested_money_list_screen.dart';
import 'package:six_cash/features/transaction_money/screens/transaction_balance_input_screen.dart';
import 'package:six_cash/features/transaction_money/screens/transaction_money_screen.dart';

class ThemeOneWidget extends StatelessWidget {
  final GlobalKeyManagerModel keyManager;
  final GlobalKey? lastKey;
  const ThemeOneWidget({super.key,required this.keyManager, this.lastKey});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return Stack(children: [
          Container(
            height: 180.0,
            color: Theme.of(context).primaryColor,
          ),

          Positioned(child: Column(
            children: [
              Container(
                width: double.infinity, height: 80.0,
                margin: const  EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                  vertical: Dimensions.paddingSizeLarge,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
                  color: Theme.of(context).cardColor,
                ),


                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,),
                    child: GetBuilder<ProfileController>( builder: (profileController) {
                      return CustomShowcaseWidget(
                        title: "here_you_get_your_available_balance".tr,
                        showcaseKey: keyManager.appbarBalanceKey,
                        subtitle: "",
                        isDone: lastKey == keyManager.appbarBalanceKey,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                          Text('your_balance'.tr, style: rubikLight.copyWith(
                            color: ColorResources.getBalanceTextColor(), fontSize: Dimensions.fontSizeLarge, height: 1.0,
                          )),

                          const SizedBox(height: Dimensions.paddingSizeExtraSmall + 2,),

                          !profileController.showBalanceButtonTapped && profileController.isUserBalanceHide() ? InkWell(
                            onTap: () => profileController.updateBalanceButtonTappedStatus(shouldUpdate: true),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeExtraExtraLarge),
                                  color: Theme.of(context).hintColor.withValues(alpha:0.1)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                const Icon(Icons.touch_app_outlined, size: 15,),
                                const SizedBox(width: 3),
                                Text("tap_for_balance".tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)
                              ]),
                            ),
                          ) : Text( PriceConverterHelper.balanceWithSymbol(balance: profileController.userInfo?.balance.toString() ?? "0.00"),
                            style: rubikMedium.copyWith(
                                color: Theme.of(context).textTheme.titleLarge!.color,
                                fontSize: Dimensions.fontSizeExtraLarge,
                                height: 1.0
                            ),
                          ),
                        ]),
                      );
                    }),
                  ),
                  const Spacer(),
                  if(splashController.configModel!.systemFeature!.addMoneyStatus!) CustomShowcaseWidget(
                    showcaseKey: keyManager.addMoneyKey,
                    title: "from_here_you_can_add_money_to_your_account",
                    subtitle: "",
                    padding: EdgeInsets.zero,
                    isDone: lastKey == keyManager.addMoneyKey,
                    radius: BorderRadius.circular(Dimensions.radiusSizeLarge),
                    child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeLarge),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),


                      child: CustomInkWellWidget(
                        onTap: () => Get.to(const TransactionBalanceInputScreen(transactionType: 'add_money')),
                        radius: Dimensions.radiusSizeLarge,
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              SizedBox(height: 34, child: Image.asset(Images.walletLogo)),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                              Text(
                                'add_money'.tr, style: rubikRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),

              /// Cards...
              SizedBox(
                height: 120.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.fontSizeExtraSmall),
                  child: Row(
                    children: [
                      if(splashController.configModel!.systemFeature!.sendMoneyStatus!) Expanded(child: OptionCardWidget(
                        showcaseKey: keyManager.sendMoneyKey,
                        showcaseTitle: 'from_here_you_can_send_your_money',
                        image: Images.sendMoneyLogo, text: 'send_money'.tr.replaceAll(' ', '\n'),
                        color: Theme.of(context).secondaryHeaderColor,
                        isDone: lastKey == keyManager.sendMoneyKey,
                        onTap: ()=> Get.to(()=> const TransactionMoneyScreen(
                          fromEdit: false,
                          transactionType: TransactionType.sendMoney,
                        )),
                      )),

                      if(splashController.configModel!.systemFeature!.cashOutStatus!)Expanded(child: OptionCardWidget(
                        showcaseTitle: "from_here_you_can_cash_out",
                        showcaseKey: keyManager.cashOutKey,
                        image: Images.cashOutLogo, text: 'cash_out'.tr.replaceAll(' ', '\n'),
                        isDone: lastKey == keyManager.cashOutKey,
                        color: ColorResources.getCashOutCardColor(),
                        onTap: ()=> Get.to(()=> const TransactionMoneyScreen(
                          fromEdit: false,
                          transactionType: TransactionType.cashOut,
                        )),
                      )),

                      if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!)Expanded(child: OptionCardWidget(
                        showcaseKey: keyManager.requestMoneyKey,
                        showcaseTitle: "from_here_you_can_request_money",
                        image: Images.requestMoney, text: 'request_money'.tr,
                        isDone: lastKey == keyManager.requestMoneyKey,
                        color: ColorResources.getRequestMoneyCardColor(),
                        onTap: ()=> Get.to(()=> const TransactionMoneyScreen(
                          fromEdit: false,
                          transactionType: TransactionType.requestMoney,
                        )),
                      )),

                      if(splashController.configModel!.systemFeature!.sendMoneyRequestStatus!) Expanded(child: OptionCardWidget(
                        showcaseKey: keyManager.sendMoneyRequestKey,
                        isDone: lastKey == keyManager.sendMoneyRequestKey,
                        showcaseTitle: "from_here_you_can_check_send_requests",
                        image: Images.requestListImage2,
                        text: 'requests'.tr,
                        color: ColorResources.getReferFriendCardColor(),
                        onTap: () => Get.to(()=> const RequestedMoneyListScreen(requestType: RequestType.request)),
                      ),
                      ),
                    ],
                  ),
                ),
              ),


              const BannerWidget(),

            ],
          )),
        ]);
      }
    );
  }

}
