import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:new_app_rivan/apis/auth_api.dart';
import 'package:new_app_rivan/core/utils.dart';
import 'package:new_app_rivan/features/auth/view/login_view.dart';
import 'package:new_app_rivan/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({
    required authAPI,
  })  : _authAPI = authAPI,
        super(false);

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  // isLoading:

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      // ignore: avoid_print
      (r) {
        showSnackBar(context, "Account Created Successfully!");
        Navigator.push(context, LoginView.route());
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      // ignore: avoid_print
      (r) {
        Navigator.push(context, HomeView.route());
      },
    );
  }
}
