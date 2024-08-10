import 'package:blog_app/core/common/loader.dart';
import 'package:blog_app/core/routes/app_routes.dart';
import 'package:blog_app/core/theme/app_color.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showCustomSnackBar(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.blog, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const CustomLoader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In.",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: "Email", controller: emailController),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                      }
                    },
                    text: "Sign In",
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signUp);
                    },
                    child: RichText(
                        text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColor.focusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
