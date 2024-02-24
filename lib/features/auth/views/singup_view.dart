import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:new_app_rivan/apis/auth_api.dart';
import 'package:new_app_rivan/common/rounded_button.dart';
import 'package:new_app_rivan/constants/ui_constants.dart';
import 'package:new_app_rivan/features/auth/controllers/auth_controller.dart';
// import 'package:new_app_rivan/features/auth/controllers/auth_controller.dart';
import 'package:new_app_rivan/features/auth/widgets/auth_field.dart';
import 'package:new_app_rivan/theme/pallete.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 30),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: () {
                      onSignUp();
                    },
                    label: 'Done',
                    backgroundColor: Pallete.whiteColor,
                    textColor: Pallete.backgroundColor,
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Pallete.blueColor,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              LoginView.route(),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
