import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/features/auth/controllers/create_account_controller.dart';
import 'package:six_cash/helper/string_parser.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/common/widgets/custom_logo_widget.dart';

class InformationView extends StatelessWidget {
  final String? phoneNumber;
  const InformationView({super.key, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      const CustomLogoWidget(height: 70, width: 70),
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeLarge),
        child: Text(
          'otp_verification'.tr,
          style: rubikMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeExtraOverLarge,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      GetBuilder<CreateAccountController>(
        builder: (createAccountController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: RichText(textAlign : TextAlign.center, text: TextSpan(
              children: [

                TextSpan(
                  text: 'we_have_send_the_code'.tr,
                  style: rubikLight.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),

                TextSpan(
                  text: " ${StringParser.maskedPhone(phoneNumber ?? createAccountController.phoneNumber ?? '0')} ",
                  style: rubikSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),

                TextSpan(
                  text: 'and_your_otp_will_expire_within'.tr,
                  style: rubikLight.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),

                TextSpan(
                  text: " 2 min",
                  style: rubikSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),


              ],
            )),
          );
        }
      ),

    ]);
  }
}
