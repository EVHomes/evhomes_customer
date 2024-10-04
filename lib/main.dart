
import 'package:ev_homes_customer/pages/start_screen.dart';
import 'package:ev_homes_customer/provider/settings_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./firebase_options.dart";
// import "pages/splash_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void setLocale(String language) {
    setState(() {
      _locale = Locale(language);
    });
  }

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      title: 'EVHomes CRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Manrope',
      ),
      home: const OnboardingScreen(),
    );
  }
}
