import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: 'Fluxstore',
            color: AppColors.black,
            size: 27,
          ),
        ],
      ),
    );
  }
}
