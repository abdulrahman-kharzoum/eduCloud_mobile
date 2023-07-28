import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/providers/user_provider.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/profile_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/screens/installments_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:educloud_mobile/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_Channel',
          channelName: "Basic Notification",
          channelDescription: "notification channel description")
    ],
    debug: true,
  );
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
        ChangeNotifierProvider<BaseProvider>(create: (_) => BaseProvider()),
        ChangeNotifierProvider<OnboardingProvider>(
            create: (_) => OnboardingProvider()),
        ChangeNotifierProvider<ModelProvider>(create: (_) => ModelProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
      ),
    );
  }
}
