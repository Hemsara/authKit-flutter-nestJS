import 'package:client/models/dto/auth/register.dto.dart';
import 'package:client/res/dimens.dart';
import 'package:client/res/navigator.dart';
import 'package:client/res/toast.dart';
import 'package:client/shared/button.dart';
import 'package:client/shared/logo.dart';
import 'package:client/shared/textfield.dart';
import 'package:client/viewmodels/auth/auth_viewmodel.dart';
import 'package:client/views/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  handleRegister() async {
    if (_formKey.currentState!.validate()) {
      AuthViewModel viewModel = context.read<AuthViewModel>();
      bool isSuccess = await viewModel.registerUserWith(
        RegisterDTO(
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            password: passwordController.text),
      );
      if (mounted) {
        if (isSuccess) {
          ToastManager.showSuccessToast(context, "Registration success");
          NavigatorHelper.to(const LoginScreen());
          return;
        }
        ToastManager.showErrorToast(context, viewModel.registeringError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthKitLogo(),
                  Row(
                    children: [
                      Flexible(
                        child: TextInputField(
                          controller: firstNameController,
                          icon: Iconsax.user,
                          hintText: "First Name",
                        ),
                      ),
                      AppDimens.gap(1),
                      Flexible(
                        child: TextInputField(
                          controller: lastNameController,
                          icon: Iconsax.user,
                          hintText: "Last Name",
                        ),
                      )
                    ],
                  ),
                  TextInputField(
                    controller: emailController,
                    icon: Iconsax.message,
                    inputType: TextFieldType.email,
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
                    isLoading: context.watch<AuthViewModel>().registering,
                    onTap: handleRegister,
                    text: "Create account",
                    outlined: false,
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
