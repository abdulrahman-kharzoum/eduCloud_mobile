import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/providers/user_provider.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/marks_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/screens/installments_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:educloud_mobile/screens/suggestions_screen.dart';
import 'package:educloud_mobile/sever/apis.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Apis(),
        ),
        ChangeNotifierProvider<BaseProvider>(create: (_) => BaseProvider()),
        ChangeNotifierProvider<OnboardingProvider>(
            create: (_) => OnboardingProvider()),
        ChangeNotifierProvider<ModelProvider>(create: (_) => ModelProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          home: SplashScreen(),
          routes: {
            settingsScreen.routeName: (context) => const settingsScreen(),
            homeScreen.routeName: (context) => homeScreen(),
            installmentsScreen.routeName: (context) =>
                const installmentsScreen(),
            suggestionScreen.routeName: (context) => const suggestionScreen(),
            marksScreen.routeName: (context) => const marksScreen(),
          }),
    );
  }
}
