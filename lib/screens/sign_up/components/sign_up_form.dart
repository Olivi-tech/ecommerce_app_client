import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/constants/app_images.dart';
import 'package:shop_app/constants/app_routes.dart';
import 'package:shop_app/db_services/firebase_auth.dart';
import '../../../Widgets/custom_button.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../constants/app_colors.dart';
import '../../../helper/keyboard.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _rePasswordVisible = ValueNotifier<bool>(false);
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  String? email;
  String? password;
  String? conformPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: _passwordVisible,
            builder: (context, passwordVisible, child) {
              return TextFormField(
                controller: passwordController,
                obscureText: !passwordVisible,
                onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.length >= 8) {
                    removeError(error: kShortPassError);
                  }
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if (value.length < 8) {
                    addError(error: kShortPassError);
                    return "";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: InkWell(
                        onTap: () {
                          _passwordVisible.value = !_passwordVisible.value;
                        },
                        child: Icon(
                            passwordVisible ? Icons.lock_open : Icons.lock))),
              );
            },
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: _rePasswordVisible,
            builder: (context, value, child) {
              return TextFormField(
                controller: rePasswordController,
                obscureText: !value,
                onSaved: (newValue) => conformPassword = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.isNotEmpty && password == conformPassword) {
                    removeError(error: kMatchPassError);
                  }
                  conformPassword = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if ((password != value)) {
                    addError(error: kMatchPassError);
                    return "";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Re-enter your password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _rePasswordVisible.value = !_rePasswordVisible.value;
                      },
                      child: Icon(value ? Icons.lock_open : Icons.lock)),
                ),
              );
            },
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: loading,
            builder: (context, value, child) {
              return CustomButton(
                loading: loading.value,
                btnText: 'Continue',
                weight: FontWeight.w500,
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    loading.value = true;
                    KeyboardUtil.hideKeyboard(context);
                    bool signUpSuccess = await AuthServices.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    );
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      FocusScope.of(context).unfocus();
                    });
                    loading.value = false;
                    if (signUpSuccess) {
                      Navigator.pushNamed(context, AppRoutes.signIn);
                    }
                  }
                },
              );
            },
          ),

        ],
      ),
    );
  }
}
