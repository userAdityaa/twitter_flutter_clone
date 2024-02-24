import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/core.dart';

// want to signup / get the user account -> Account
// want to access user related data -> model.Account

final authAPIProvider = Provider(
  (ref) {
    return AuthAPI(
      account: ref.watch(appwriteAccountProvider),
    );
  },
);

abstract class IAuthAPI {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? "Some Unexpected Error Occurred", stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
