import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';

Future<void> showCustomBottomSheet({required Widget child}) async {
  await Get.bottomSheet(
    ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(Get.context!).size.height * 0.8),
      child: child,
    ),
    useRootNavigator: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    barrierColor: Colors.black.withValues(alpha:Get.isDarkMode ? 0.8 : 0.6 ),
    shape:  const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radiusSizeExtraLarge),
        topRight: Radius.circular(Dimensions.radiusSizeExtraLarge),
      ),
    ),
  );
}
