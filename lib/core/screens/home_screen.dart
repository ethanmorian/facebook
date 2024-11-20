import 'package:facebook/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authProvider).signOut();
          },
          child: Text(
            'Log out',
          ),
        ),
      ),
    );
  }
}
