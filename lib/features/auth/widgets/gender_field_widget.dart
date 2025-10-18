import 'package:six_cash/features/setting/controllers/edit_profile_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gender_card_widget.dart';
class GenderFieldWidget extends StatelessWidget {
  final bool fromEditProfile;
  const GenderFieldWidget({
    super.key,
    this.fromEditProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(builder: (controller){
      return Container(
        width: double.infinity,
        padding:  EdgeInsets.only(
          top: Dimensions.paddingSizeExtraLarge,
          left: fromEditProfile ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeDefault,
          right: fromEditProfile ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeDefault,
          bottom: Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: ColorResources.getShadowColor().withValues(alpha:0.08),
                blurRadius: 20,
                offset: const Offset(0, 3),
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'select_your_gender'.tr,
              style: rubikMedium.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Wrap(
              spacing: Dimensions.paddingSizeSmall,
              runSpacing: Dimensions.paddingSizeSmall,
              children: [
                GenderCardWidget(
                  icon: Images.male,
                  text: 'male'.tr,
                  color: controller.gender?.toLowerCase() == 'male'
                      ? Theme.of(context).secondaryHeaderColor
                      : ColorResources.genderDefaultColor.withValues(alpha:0.5),
                  onTap: (){
                    controller.setGender('Male');
                  },
                ),
                //const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                GenderCardWidget(
                  icon: Images.female,
                  text: 'female'.tr,
                  color: controller.gender?.toLowerCase() == 'female'
                      ? Theme.of(context).secondaryHeaderColor
                      : ColorResources.genderDefaultColor.withValues(alpha:0.5),
                  onTap: (){
                    controller.setGender('Female');
                  },
                ),
                //const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                GenderCardWidget(
                  icon: Images.other,
                  text: 'other'.tr,
                  color: controller.gender?.toLowerCase() == 'other'
                      ? Theme.of(context).secondaryHeaderColor
                      : ColorResources.genderDefaultColor.withValues(alpha:0.5),
                  onTap: (){
                    controller.setGender('Other');
                  },
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}