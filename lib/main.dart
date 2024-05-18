import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/favourite_provider.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'firebase_options.dart';
import 'providers/bottom_navigation_provider.dart';
import 'routes.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavBarProvider>(
          create: (context) => BottomNavBarProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Flutter Way - Template',
        theme: AppTheme.lightTheme(context),
        initialRoute: CompleteProfileScreen.routeName,
        routes: routes,
      ),
    );
  }
}
