import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/common/widgets/custom_pop_scope_widget.dart';
import 'package:six_cash/features/auth/controllers/auth_controller.dart';
import 'package:six_cash/features/camera_verification/screens/camera_screen.dart';
import 'package:six_cash/features/home/controllers/menu_controller.dart';
import 'package:six_cash/features/home/domain/enums/nav_bar_page_enum.dart';
import 'package:six_cash/features/home/widgets/bottom_item_widget.dart';
import 'package:six_cash/features/home/widgets/floating_action_button_widget.dart';
import 'package:six_cash/features/home/widgets/show_case/showcaseview.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';

class NavBarScreen extends StatefulWidget {
  final String? selectedPage;
  const NavBarScreen({super.key, this.selectedPage});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();

    final MenuItemController menuItemController = Get.find();

    NavBarPageEnum navBarPageEnum = _getNavPageEnum(widget.selectedPage);

    switch(navBarPageEnum){
      case NavBarPageEnum.home :
        menuItemController.selectHomePage(isUpdate: false);
        break;
      case NavBarPageEnum.history :
        menuItemController.selectHistoryPage(isUpdate: false);
        break;
      case NavBarPageEnum.notification :
        menuItemController.selectNotificationPage(isUpdate: false);
        break ;
      case NavBarPageEnum.profile :
        menuItemController.selectProfilePage(isUpdate: false);
        break;
    }


    Get.find<AuthController>().checkBiometricWithPin();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuItemController>(builder: (menuController) {

      final padding = MediaQuery.of(context).padding;

      return CustomPopScopeWidget(
        onPopInvoked: (){
          if(menuController.currentTabIndex != 0) {
            menuController.resetNavBarTabIndex(isUpdate: true);
          }
        },
        isExit: menuController.currentTabIndex == 0 && !Get.find<AuthController>().getTourWidgetStatus(),
        child: ShowCaseWidget(
          onFinish: (){
            Get.find<AuthController>().setTourWidgetStatus(false);
            if(GetPlatform.isAndroid){
              FirebaseMessaging.instance.requestPermission();
            }
          },
          builder : (context) => Scaffold(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            body: PageStorage(bucket: bucket, child: menuController.screen[menuController.currentTabIndex]),

            floatingActionButton: FloatingActionButtonWidget(
              strokeWidth: 1.5,
              radius: 50,
              gradient: LinearGradient(
                colors: [
                  ColorResources.gradientColor,
                  ColorResources.gradientColor.withValues(alpha:0.5),
                  ColorResources.secondaryColor.withValues(alpha:0.3),
                  ColorResources.gradientColor.withValues(alpha:0.05),
                  ColorResources.gradientColor.withValues(alpha:0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                elevation: 1,
                onPressed: ()=> Get.to(()=> const CameraScreen(
                  fromEditProfile: false, isBarCodeScan: true, isHome: true,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Image.asset(Images.scannerIcon),
                ),
              ),
            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: Container(
              padding: EdgeInsets.only(top: Dimensions.paddingSizeDefault,
                bottom: padding.bottom > 15 ? 0 : Dimensions.paddingSizeDefault,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.getBlackAndWhite().withValues(alpha:0.14),
                    blurRadius: 80, offset: const Offset(0, 20),
                  ),
                  BoxShadow(
                    color: ColorResources.getBlackAndWhite().withValues(alpha:0.20),
                    blurRadius: 0.5, offset: const Offset(0, 0),
                  ),
                ],
              ),

              child: SafeArea(
                child: Row(children: [

                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

                      BottomItemWidget(
                        onTap: () => menuController.selectHomePage(),
                        icon: menuController.currentTabIndex == 0 ? Images.homeIconBold : Images.homeIcon,
                        name: 'home'.tr,
                        selectIndex: 0,
                      ),

                      BottomItemWidget(
                        onTap: () => menuController.selectHistoryPage(),
                        icon: menuController.currentTabIndex == 1
                            ? Images.clockIconBold : Images.clockIcon,
                        name: 'history'.tr, selectIndex: 1,
                      ),

                    ]),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [

                      BottomItemWidget(
                        onTap: () => menuController.selectNotificationPage(),
                        icon: menuController.currentTabIndex == 2
                            ? Images.notificationIconBold : Images.notificationIcon,
                        name: 'notification'.tr, selectIndex: 2,
                      ),

                      BottomItemWidget(
                        onTap: () => menuController.selectProfilePage(),
                        icon: menuController.currentTabIndex == 3
                            ? Images.profileIconBold : Images.profileIcon,
                        name: 'profile'.tr,
                        selectIndex: 3,
                      ),

                    ]),
                  ),

                ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  NavBarPageEnum _getNavPageEnum(String? page){
    switch(page ?? false){
      case 'home':
        return NavBarPageEnum.home;
      case 'notification':
        return NavBarPageEnum.notification;
      case 'profile':
        return NavBarPageEnum.profile;
      case 'history':
        return NavBarPageEnum.history;
      default:
        return NavBarPageEnum.home;
    }
  }

}



