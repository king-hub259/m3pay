import 'package:country_code_picker/country_code_picker.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:six_cash/common/widgets/custom_pop_scope_widget.dart';
import 'package:six_cash/common/widgets/custom_text_field_widget.dart';
import 'package:six_cash/common/widgets/text_field_title.dart';
import 'package:six_cash/features/auth/controllers/auth_controller.dart';
import 'package:six_cash/features/auth/controllers/create_account_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/common/widgets/custom_app_bar_widget.dart';
import 'package:six_cash/common/widgets/custom_logo_widget.dart';
import 'package:six_cash/common/widgets/custom_large_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});


  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController numberFieldController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScopeWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: CustomAppbarWidget(
          title: 'create_account'.tr,
          isBackButtonExist: false,
        ),
        body: Form(
          key: formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      
            Expanded(
              child: SingleChildScrollView(child: Column(children: [
      
                const SizedBox(height: Dimensions.paddingSizeExtraExtraLarge),
      
                const CustomLogoWidget(height: 70.0, width: 70.0),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
      
                Text('enter_mobile_number'.tr,
                  style : rubikSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
      
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                  child: Text('${'create'.tr} ${AppConstants.appName} ${'account_with_your'.tr}', style: rubikRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,), textAlign: TextAlign.center,),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: TextFieldTitle(title: "phone_number".tr),
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: GetBuilder<CreateAccountController>(
                    id: 'countryCode',
                    builder: (createAccountController) {
                      return CustomTextFieldWidget(
                        countryDialCode: createAccountController.countryCode,
                        onCountryChanged: (CountryCode countryCode) => createAccountController.setCountryCode(countryCode.dialCode!),
                        hintText: "12XXXXXXXXX".tr,
                        controller:  numberFieldController,
                        isShowBorder: true,
                        inputType: TextInputType.phone,
                        isAutoFocus: true,
                        onValidate: (phone){
                          String phoneNumber = '${createAccountController.countryCode}${numberFieldController.text}';
                          PhoneNumber phone = PhoneNumber.parse(phoneNumber);
                          if(phone.isValid(type: PhoneNumberType.mobile)){
                            return null;
                          }
                          return "please_input_your_valid_number".tr;
                        },
                      );
                     },
                    ),
                ),
      
              ])),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            SafeArea(
              child: GetBuilder<AuthController>(builder: (controller)=> CustomLargeButtonWidget(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                text: 'next'.tr,
                fontSize: Dimensions.fontSizeLarge,
                isLoading: controller.isLoading,
                onTap: () async {
                  String phone = '${Get.find<CreateAccountController>().countryCode}${numberFieldController.text}';
                  if(formKey.currentState!.validate()){
                    Get.find<CreateAccountController>().sendOtpResponse(number: phone);
                  }
                },
              )),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ]),
        ),
      ),
    );
  }
}
