import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import '../providers/bottom_navigation_provider.dart';
import 'cart/cart_screen.dart';

const Color inActiveIconColor = AppColors.darkGrey;

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});
  static String routeName = "/";

  final List<Widget> pages = const [
    HomeScreen(),
    FavoriteScreen(),
    Center(
      child: Text("Chat"),
    ),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavBarProvider>(
        builder: (context, provider, child) {
          return pages[provider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavBarProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            backgroundColor: AppColors.greyColor,
            onTap: (index) => provider.updateIndex(index),
            currentIndex: provider.currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/favourite.png",
                  color: inActiveIconColor,
                ),
                activeIcon: Image.asset(
                  "assets/icons/favourite.png",
                  color: kPrimaryColor,
                ),
                label: "Fav",
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.message_sharp,
                  color: inActiveIconColor,
                ),
                activeIcon: Icon(
                  Icons.chat,
                  color: kPrimaryColor,
                ),
                label: "Chat",
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: inActiveIconColor,
                ),
                activeIcon: Icon(
                  Icons.shopping_cart,
                  color: kPrimaryColor,
                ),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: inActiveIconColor,
                ),
                activeIcon: Icon(
                  Icons.person_2_outlined,
                  color: kPrimaryColor,
                ),
                label: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
