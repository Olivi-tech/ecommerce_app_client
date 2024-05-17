import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_colors.dart';

import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: 20),
            Categories(),
            DiscountBanner(),
            SpecialOffers(),
            SizedBox(height: 20),
            PopularProducts(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
