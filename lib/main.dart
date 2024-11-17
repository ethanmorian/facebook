import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/config/routes/routes.dart';
import 'features/auth/presentation/screens/verify_email_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VerifyEmailScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
