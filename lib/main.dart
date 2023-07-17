import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:educloud_mobile/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    
    await EasyLocalization(
      path: 'assets/translations/',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MyApp()),
    
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
     MultiProvider(providers: [
      ChangeNotifierProvider<BaseProvider>(create: (_) => BaseProvider()),
      ChangeNotifierProvider<OnboardingProvider>(
          create: (_) => OnboardingProvider()),
      ChangeNotifierProvider<ModelProvider>(create: (_) => ModelProvider()),],

    child: MaterialApp(
      

        debugShowCheckedModeBanner: false,
      navigatorKey: nav,
        routes: {
          settingsScreen.routeName: (context) => const settingsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        locale: context.locale,
        home: HomeScreen(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
          useMaterial3: true,
        ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        theme: ThemeData(
        title: 'Flutter Demo',