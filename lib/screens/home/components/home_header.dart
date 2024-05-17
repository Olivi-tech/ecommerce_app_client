import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/constants/app_images.dart';
import 'package:shop_app/screens/cart/components/custom_text.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'package:gap/gap.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Image.asset(
          AppImages.blur,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Image.asset(
          AppImages.sparkle,
        ),
      ),
      actions: const <Widget>[
        Row(
          children: [
            CustomText(
              title: 'Fluxstore',
              color: AppColors.black,
              size: 27,
            ),
            Gap(70),
            Padding(
              padding: EdgeInsets.only(top: 7),
              child: Icon(
                Icons.search,
                size: 30,
                color: AppColors.black,
              ),
            ),
            Gap(10),
          ],
        )
      ],
    );
  }
}
