import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(await EasyLocalization(
      path: 'assets/translations/',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        home: HomeScreen(),
        routes: {
          settingsScreen.routeName: (context) => const settingsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        });
  }
}
