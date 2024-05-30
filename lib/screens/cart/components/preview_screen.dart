import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/Widgets/custom_text_field.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/constants/app_images.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';
class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});
  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}
class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const CustomText(title: 'Order details',size: 17,weight: FontWeight.w600,),
                const Gap(20),
                Container(
                  height: 150,
                  decoration: BoxDecoration(color: AppColors.greyColor,borderRadius: BorderRadius.circular(10)),
                  child: Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Image.asset(AppImages.shirt),
                     ),
                        const Row(

                          children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            CustomText(title: 'Product Name',weight: FontWeight.w700,size: 16,),
                            CustomText(title: '\$${50.00}',weight: FontWeight.w700,size: 16,),
                          ],)
                        ],)
                    ],

                    ),
                  ),

                ),
                  const Gap(10),
                  const Divider(color: AppColors.black,),
                  const Gap(20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    CustomText(title: 'Subtotal',weight: FontWeight.w500,size: 15,),
                    CustomText(title: '\$${50.00}',weight: FontWeight.w500,size: 15,),
                  ],),
                  const Gap(10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(title: 'Shipping',weight: FontWeight.w500,size: 15,),
                      CustomText(title: '\$${50.00}',weight: FontWeight.w500,size: 15,),
                    ],),
                 const Gap(10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(title: 'Total',weight: FontWeight.w700,size: 16,),
                      CustomText(title: '\$${50.00}',weight: FontWeight.w700,size: 16,),
                    ],

                  ),
                  const Gap(40),
                  const CustomText(title: 'Your Note',weight: FontWeight.w700,size: 17,),
                  const Gap(10),
                const  CustomTextField(hintText: 'Enter something',isCommentField: true,)
                ],
              ),
            ],

          ),
        )


      ),

    );

  }
}
