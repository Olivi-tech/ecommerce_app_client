import 'package:flutter/material.dart';
import 'package:shop_app/utils/app_utils.dart';
import '../../../Widgets/custom_button.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import '../../../constants/app_colors.dart';
import '../../../db_services/firebase_auth.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
  TextEditingController emailController = TextEditingController();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    double width = size.width;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          ValueListenableBuilder(
            valueListenable: loadingNotifier,
            builder: (context, isLoading, child) => CustomButton(
              fixedHeight: height * 0.07,
              fixedWidth: width,
              btnText: 'Continue',
              loading: loadingNotifier.value,
              backgroundColor: AppColors.red,
              weight: FontWeight.w700,
              textColor: AppColors.white,
              textSize: 13,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  loadingNotifier.value = true;
                  String result = await AuthServices.forgotPassword(
                      email: emailController.text, context: context);
                  if (result == 'success') {
                    AppUtils.toastMessage(
                        'Password reset email send successfully');
                  } else {
                    AppUtils.toastMessage(result);
                    loadingNotifier.value = false;
                  }
                  loadingNotifier.value = false;
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          const NoAccountText(),
        ],
      ),
    );
  }
}
