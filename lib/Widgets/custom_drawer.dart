import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_colors.dart';
import '../screens/cart/components/custom_text.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Drawer(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(color: AppColors.red),
            child: const Column(
              children: [
                Gap(50),
                CustomText(
                  title: 'Fluxstore',
                  color: AppColors.black,
                  size: 27,
                ),
                Gap(20),
                Divider(
                  endIndent: 20,
                  indent: 20,
                  color: AppColors.black,
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.home,
                  text: 'Home',
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.favorite_border_outlined,
                  text: 'Favourite',
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.shopping_cart,
                  text: 'Cart',
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.chat,
                  text: 'Chat',
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.person_2_outlined,
                  text: 'Setting',
                ),
                Gap(20),
                IconTextRow(
                  icon: Icons.logout_outlined,
                  text: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double iconSize;
  final TextStyle textStyle;

  const IconTextRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
    this.textStyle = const TextStyle(fontSize: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
        const Gap(30),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}
