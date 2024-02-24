import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:new_app_rivan/apis/auth_api.dart';
import 'package:new_app_rivan/core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authAPI: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;

  AuthController({
    required authAPI,
  })  : _authAPI = authAPI,
        super(false);

  // isLoading:

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    res.fold(
      (l) => showSnackBar(context, l.message),
      // ignore: avoid_print
      (r) => print(r.email),
    );
  }
}
