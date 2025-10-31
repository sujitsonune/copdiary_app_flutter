import 'package:copdiary/login_page.dart';
import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies (GetIt, etc.) as per CORE_SETUP_README.md
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Copdiary',
      debugShowCheckedModeBanner: false,
      // Set the new LoginPage as the home screen
      home: const LoginPage(),
    );
  }
}
