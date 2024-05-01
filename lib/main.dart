import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glumate_flutter/core/localization/appLocalization.dart';

import 'package:glumate_flutter/presentation/register_auth/providers/Locale_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/providers/register_auth_provider.dart';
import 'package:glumate_flutter/presentation/register_auth/widgets/main_tab.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_charts_provider.dart';
import 'package:glumate_flutter/presentation/tracking_glucose/providers/gluc_record_provider.dart';

import 'package:glumate_flutter/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:glumate_flutter/presentation/register_auth/widgets/Notification/NotificationService.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBlue flutterBlue = FlutterBlue.instance;

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize the NotificationService
  NotificationService notificationService = NotificationService();
  await notificationService.init(); // Call the init method
 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => RegisterAuthProvider()),
             ChangeNotifierProvider(create: (_) => GlucoseProvider()),
               ChangeNotifierProvider(create: (_) => ChartsProvider()),
           //  ChangeNotifierProvider(create: (_) => GlucoseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: const [
        Locale("en", ""),
        Locale("fr", ""),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WidgetTree(),
    );
  }
}
