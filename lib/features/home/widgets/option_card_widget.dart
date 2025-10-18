import 'package:six_cash/common/widgets/custom_showcase_widget.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:six_cash/common/widgets/custom_ink_well_widget.dart';
class OptionCardWidget extends StatelessWidget {
  final String? image;
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  final GlobalKey  showcaseKey;
  final String? showcaseTitle;
  final bool isDone;
   const OptionCardWidget({super.key, this.image, this.text, this.onTap, this.color, required  this.showcaseKey,   this.showcaseTitle, required this.isDone}) ;

  @override
  Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault), color: color,
         boxShadow: [BoxShadow(color: Theme.of(context).cardColor.withValues(alpha:0.1), blurRadius: 40, offset: const Offset(0, 4))]),

       child: CustomShowcaseWidget(
         showcaseKey: showcaseKey,
         title: showcaseTitle ?? "",
         subtitle: "",
         padding: EdgeInsets.zero,
         radius: BorderRadius.circular(Dimensions.radiusSizeLarge),
         isDone: isDone,
         child: CustomInkWellWidget(
           onTap: onTap,
           radius: Dimensions.radiusSizeDefault,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               const SizedBox(height: Dimensions.paddingSizeDefault),
               Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                 decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha:0.7)),
                 child: SizedBox(height: 25, width: 25,
                   child: Image.asset(image!, fit: BoxFit.contain))),
               const SizedBox(height: 10),



               Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall+1),
                 child: Text(text!, textAlign: TextAlign.center, maxLines: 2, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
               )
             ],
           ),
         ),
       ),
     );
  }
}