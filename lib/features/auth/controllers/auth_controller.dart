import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:new_app_rivan/apis/auth_api.dart';
import 'package:new_app_rivan/apis/user_api.dart';
import 'package:new_app_rivan/core/utils.dart';
import 'package:new_app_rivan/features/auth/view/login_view.dart';
import 'package:new_app_rivan/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as model;
import 'package:new_app_rivan/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({
    required authAPI,
    required userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
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
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          followers: const [],
          following: const [],
          isTwitterBlue: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, "Account Created Successfully!");
          Navigator.push(context, LoginView.route());
        });
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

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
