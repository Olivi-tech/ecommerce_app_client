import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/Widgets/custom_button.dart';
import 'package:shop_app/constants/app_routes.dart';
import 'package:shop_app/db_services/firebase_auth.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../constants.dart';
import '../../../constants/app_colors.dart';
import '../../../helper/keyboard.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);
  String? email;
  String? password;
  bool? remember = false;
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
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.forgetPassword),
              child: const Text(
                "Forgot Password",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
                    bool loginSuccess = await AuthServices.login(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    );
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      FocusScope.of(context).unfocus();
                    });
                    loading.value = false;
                    if (loginSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.initScreen,
                            (route) => false,
                      );
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
