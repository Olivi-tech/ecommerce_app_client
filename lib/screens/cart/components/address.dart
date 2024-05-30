import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/Widgets/custon_form_field.dart';
import '../../../Widgets/custom_button.dart';
import '../../../constants/app_colors.dart';
import '../../../helper/keyboard.dart';
class AddressScreen extends StatefulWidget {
  final TabController controller;
  const AddressScreen({super.key, required this.controller});
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}
final _formKey = GlobalKey<FormState>();
class _AddressScreenState extends State<AddressScreen> {
  void _navigateToPayment(BuildContext context) {
    widget.controller.animateTo(1); // Move to the second tab
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomFormField(
                          labelText: 'First Name',
                          keyBoardType: TextInputType.name,
                        ),
                        const Gap(10),
                        const CustomFormField(
                          labelText: 'Last Name',
                          keyBoardType: TextInputType.name,
                        ),
                        const Gap(10),
                        CustomFormField(
                          labelText: 'Phone No.',
                          keyBoardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const Gap(10),
                        const CustomFormField(
                          labelText: 'Email',
                          keyBoardType: TextInputType.emailAddress,
                        ),
                        const Gap(10),
                        CustomButton(
                          fixedHeight: 40,
                          btnText: 'SEARCH ADDRESS',
                          weight: FontWeight.w500,
                          backgroundColor: AppColors.red,
                          textColor: AppColors.white,
                          onPressed: () async {
                            KeyboardUtil.hideKeyboard(context);
                          },
                        ),
                        const Gap(10),
                        CustomButton(
                          fixedHeight: 40,
                          btnText: 'SELECT ADDRESS',
                          weight: FontWeight.w500,
                          backgroundColor: AppColors.red,
                          textColor: AppColors.white,
                          onPressed: () async {
                            KeyboardUtil.hideKeyboard(context);
                          },
                        ),
                        const Gap(10),
                        const CustomFormField(
                          labelText: 'City',
                          keyBoardType: TextInputType.name,
                        ),
                        const Gap(10),
                        CustomFormField(
                          labelText: 'Zip Code',
                          keyBoardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: CustomButton(
                  fixedHeight: 50,
                  fixedWidth: 200,
                  btnText: 'CONTINUE TO PREVIEW',
                  weight: FontWeight.w500,
                  backgroundColor: AppColors.red,
                  textColor: AppColors.white,
                  onPressed: () async {
                    KeyboardUtil.hideKeyboard(context);
                    _navigateToPayment(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
