import 'package:flutter/material.dart';
import 'package:shop_app/screens/chat_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/products/see_more_deals.dart';
import 'package:shop_app/screens/products/see_more_products.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'constants/app_routes.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/products/deals_products_screen.dart';
import 'screens/products/popular_product_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.signIn) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.signUp) {
    return animatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.forgetPassword) {
    return animatePage(const ForgotPasswordScreen());
  } else if (settings.name == AppRoutes.completeProfile) {
    return animatePage(const CompleteProfileScreen());
  } else if (settings.name == AppRoutes.otpScreen) {
    return animatePage(const OtpScreen());
  } else if (settings.name == AppRoutes.initScreen) {
    return animatePage(const InitScreen());
  } else if (settings.name == AppRoutes.homescreen) {
    return animatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.setting) {
    return animatePage(const ProfileScreen());
  } else if (settings.name == AppRoutes.chat) {
    return animatePage(const ChatScreen());
  } else if (settings.name == AppRoutes.dealsSeemore) {
    return animatePage(const DealsScreen());
  } else if (settings.name == AppRoutes.productSeemore) {
    final Map<String, dynamic> categoriesproduct =
        settings.arguments as Map<String, dynamic>;
    final String categories = categoriesproduct['categories'] as String;
    return animatePage(SeeMoreProduct(category: categories));
  } else if (settings.name == AppRoutes.deals) {
    final Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
    final String category = arguments['category'] as String;
    return animatePage(DealsPRoductScreen(
      category: category,
    ));
  } else if (settings.name == AppRoutes.popularProduct) {
    final Map<String, dynamic> populararguments =
        settings.arguments as Map<String, dynamic>;
    final String popularCategory =
        populararguments['popular_category'] as String;
    return animatePage(PopularProductsScreen(
      category: popularCategory,
    ));
  } else {
    return animatePage(const SplashScreen());
  }
}

PageRouteBuilder animatePage(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return customLeftSlideTransition(animation, child);
    },
  );
}

Widget customLeftSlideTransition(Animation<double> animation, Widget child) {
  Tween<Offset> tween =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
  return SlideTransition(
    position: tween.animate(animation),
    child: child,
  );
}

PageRouteBuilder rightToLeftAnimatePage(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return customRightSlideTransition(animation, child);
    },
  );
}

Widget customRightSlideTransition(Animation<double> animation, Widget child) {
  Tween<Offset> tween =
      Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
  return SlideTransition(
    position: tween.animate(animation),
    child: child,
  );
}
