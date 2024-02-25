import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app_rivan/common/error_page.dart';
import 'package:new_app_rivan/common/loading_page.dart';
import 'package:new_app_rivan/features/auth/controllers/auth_controller.dart';
import 'package:new_app_rivan/features/auth/view/singup_view.dart';
import 'package:new_app_rivan/features/home/view/home_view.dart';
// import 'package:app/theme/theme.dart';
import 'package:new_app_rivan/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              } else {
                return const SignUpView();
              }
            },
            error: (error, st) => ErrorPage(error: error as String),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
