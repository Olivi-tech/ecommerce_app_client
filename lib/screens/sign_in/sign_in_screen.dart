import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_images.dart';

import '../../components/no_account_text.dart';
import '../../components/socal_card.dart';
import '../../constants/app_routes.dart';
import '../../db_services/firebase_auth.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const SignForm(),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google.svg",
                      press: () async {
                        await AuthServices.signInWithGoogle();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.initScreen, (route) => false);
                      },
                    ),
                    SocalCard(
                      icon: 'assets/icons/apple_icon.svg',
                      press: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
