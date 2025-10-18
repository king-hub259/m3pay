
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/features/language/controllers/localization_controller.dart';
import 'package:six_cash/helper/route_helper.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/common/widgets/custom_app_bar_widget.dart';
import 'package:six_cash/common/widgets/custom_logo_widget.dart';
import 'package:six_cash/common/widgets/custom_small_button_widget.dart';
import 'package:six_cash/helper/custom_snackbar_helper.dart';
import 'package:six_cash/features/language/widgets/language_widget.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  
  @override
  void initState() {
    final LocalizationController localizationController = Get.find<LocalizationController>();

    localizationController.loadCurrentLanguage().then((index) => localizationController.setSelectIndex(index, isUpdate: false));
    super.initState();
  }

  @override
  void dispose() {
    final LocalizationController localizationController = Get.find<LocalizationController>();

    localizationController.loadCurrentLanguage().then((index) => localizationController.setSelectIndex(index, isUpdate: false));
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(title: 'language'.tr,
        onlyTitle: !Navigator.canPop(Get.context!),
      ),
      body: GetBuilder<LocalizationController>(
          builder: (localizationController) {
        return Column(children: [
          Expanded(
              child: Center(child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Center(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: CustomLogoWidget(
                            height: 120,
                            width: 120,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeOverLarge,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  Dimensions.paddingSizeDefault),
                          child:
                              Text('select_language'.tr, style: rubikMedium.copyWith(color: Theme.of(context).textTheme.titleLarge!.color,fontSize: Dimensions.fontSizeExtraLarge)),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1), mainAxisSpacing: 5, crossAxisSpacing: 5,
                          ),
                          itemCount: localizationController.languages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => LanguageWidget(
                            languageModel: localizationController.languages[index],
                            localizationController: localizationController,
                            index: index,
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        Padding( padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Text('* ${'you_can_change_language'.tr}',
                              style: rubikRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).disabledColor,
                              )),
                        ),
                      ]),
                )),
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge, right: Dimensions.paddingSizeExtraLarge, bottom: Dimensions.paddingSizeExtraExtraLarge),
            child: Row(
              children: [
                Expanded(
                  child: CustomSmallButtonWidget(
                    onTap: () {
                      if (localizationController.languages.isNotEmpty &&
                          localizationController.selectedIndex != -1) {


                        localizationController.setLanguage(Locale(
                          AppConstants.languages[localizationController.selectedIndex]
                              .languageCode!,
                          AppConstants.languages[localizationController.selectedIndex]
                              .countryCode,
                        ));
                        if(!Navigator.canPop(Get.context!)){
                          Get.offNamed(RouteHelper.getChoseLoginRegRoute());
                        }else{
                          Get.back();
                        }

                      } else {
                        showCustomSnackBarHelper('select_a_language'.tr,isError: false);
                      }
                    },
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    text: 'save'.tr,
                    textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
