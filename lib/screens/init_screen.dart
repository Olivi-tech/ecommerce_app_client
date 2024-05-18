import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import '../providers/bottom_navigation_provider.dart';

const Color inActiveIconColor = AppColors.black;

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});
  static String routeName = "/";

  final List<Widget> pages = const [
    HomeScreen(),
    FavoriteScreen(),
    Center(
      child: Text("Chat"),
    ),
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
                  "assets/icons/Shop Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Fav",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icons/Chat bubble Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    inActiveIconColor,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  colorFilter: const ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
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
