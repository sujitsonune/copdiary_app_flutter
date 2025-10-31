
import 'package:flutter/material.dart';
import 'core/di/injection.dart';


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
     home: Scaffold(
  appBar: AppBar(title: const Text('CopDiary App')),
  body: const Center(
    child: Text('App Loaded Successfully!'),
  ),
),
    );
  }
}
