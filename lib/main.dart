import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/login.dart';
import 'package:educloud_mobile/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool('showLogin') ?? false;
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<BaseProvider>(create: (_) => BaseProvider()),
      ChangeNotifierProvider<OnboardingProvider>(
          create: (_) => OnboardingProvider()),
      ChangeNotifierProvider<ModelProvider>(create: (_) => ModelProvider()),
    ], child: MyApp(showLogin: showLogin)),
  );
}

class MyApp extends StatelessWidget {
  final bool showLogin;

  const MyApp({
    Key? key,
    required this.showLogin,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   //   bottomSheetTheme: BottomSheetThemeData(
      //   // backgroundColor: Colors.black.withOpacity(0),
      // )),
      home: showLogin
          ? LoginScreen()
          : OnboardingScreen(), //: OnboardingScreen(),
    );
  }
}
