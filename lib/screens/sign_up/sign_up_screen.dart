import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_routes.dart';
import 'package:shop_app/db_services/firebase_auth.dart';

import '../../components/socal_card.dart';
import '../../constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Register Account", style: headingStyle),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignUpForm(),
                  const SizedBox(height: 16),
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
                        icon: "assets/icons/apple_icon.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'By continuing your confirm that you agree \nwith our Term and Condition',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
