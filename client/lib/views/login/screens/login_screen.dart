import 'package:client/models/dto/auth/login.dto.dart';
import 'package:client/res/dimens.dart';
import 'package:client/res/navigator.dart';
import 'package:client/res/toast.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/logo.dart';
import 'package:client/shared/textfield.dart';
import 'package:client/viewmodels/auth/auth_viewmodel.dart';
import 'package:client/views/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      AuthViewModel viewModel = context.read<AuthViewModel>();
      bool success = await viewModel.loginWith(LoginDTO(
          email: emailController.text, password: passwordController.text));
      if (mounted) {
        if (success) {
          ToastManager.showSuccessToast(context, "You are now logged in!");
          NavigatorHelper.popAll();
          NavigatorHelper.replaceAll(const HomeScreen());
          return;
        }
        ToastManager.showErrorToast(context, viewModel.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthKitLogo(),
                TextInputField(
                  controller: emailController,
                  inputType: TextFieldType.email,
                  icon: Iconsax.user,
                  hintText: "E-mail address",
                ),
                TextInputField(
                  controller: passwordController,
                  icon: Iconsax.key,
                  inputType: TextFieldType.password,
                  hintText: "Password",
                ),
                AppDimens.gap(1),
                PrimaryButton(
                  isLoading: context.watch<AuthViewModel>().loginIn,
                  text: "Login",
                  onTap: handleLogin,
                  outlined: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
