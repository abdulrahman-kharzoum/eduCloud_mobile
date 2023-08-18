import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/Sigin_buttom_widget.dart';
import 'package:educloud_mobile/constants/sharedPreferences.dart';
import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/providers/user_provider.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:space_fixer/space_fixer.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _controller = PageController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode passNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: ImageClipPathBetter(),
              child: Consumer<OnboardingProvider>(
                builder: (context, imageProvider, _) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Image.asset(
                      imageProvider.currentImagePath,
                      key: ValueKey(imageProvider.currentImagePath),
                      fit: BoxFit.cover,
                      height: imageProvider.size.height / 1.7,
                      width: imageProvider.size.width,
                    ),
                  );
                },
              ),
            ),
            Consumer<OnboardingProvider>(
              builder: (context, value, _) {
                //print(imageProvider.size);
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    key: ValueKey(value.currentImagePath),
                    pause: Duration(milliseconds: 2000),
                    // isRepeatingAnimation: false,
                    animatedTexts: [
                      value.textWidgets,
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<OnboardingProvider>(
              builder: (context, value, _) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    key: ValueKey(value.currentImagePath),
                    pause: Duration(milliseconds: 2000),
                    // isRepeatingAnimation: false,
                    animatedTexts: [
                      value.subtextsWidgets,
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Consumer<OnboardingProvider>(
              builder: (context, value, child) => SmoothPageIndicator(
                effect: JumpingDotEffect(
                  activeDotColor: AppColors.primaryColor,
                  dotColor: AppColors.textColor,
                  offset: 20,
                  jumpScale: 4,
                  // verticalOffset: 10,
                ),
                controller: _controller,
                count: 3,
              ),
            ),
            Expanded(
              flex: 1,
              child: Consumer<OnboardingProvider>(
                builder: (context, value, child) {
                  value.setcontroller(_controller);
                  return PageView(
                    allowImplicitScrolling: false,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: [
                      Container(
                        color: Colors.white,
                      ),
                      Container(
                        color: Colors.white,
                      ),
                      Container(
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        bottomSheet: CustomPaint(
          size: Size(double.infinity,
              (double.infinity * 0.4696132596685083 - 30).toDouble()),
          painter: RPSCustomPainter(),
          child: Container(
            // color: Colors.white,
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Consumer<OnboardingProvider>(
                  builder: (context, value, child) => InkWell(
                    onTap: () async {
                      // final prefs = await SharedPreferences.getInstance();
                      // prefs.setBool('showLogin', true);

                      Model _model = new Model();
                      _model.passwordController = passwordController;
                      _model.userNameController = userNameController;

                      showModalBottomSheet(
                        isScrollControlled: true,
                        // barrierColor: Colors.transparent,

                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => buildSheet(value.size, _model),
                      );
                    },
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          LocaleKeys.signIn.tr(),
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
  Widget buildSheet(Size size, Model _model) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: makeDismissible(
            child: DraggableScrollableSheet(
              initialChildSize: 0.662,
              builder: (context, scrollController) => Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    // physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      CustomPaint(
                        size: Size(size.width,
                            (size.width * 0.4696132596685083 - 30).toDouble()),
                        painter: RPSCustomPainter(),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 100,
                                width: double.infinity,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                        LocaleKeys.signIn.tr(),
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        height: 2,
                                        thickness: 2,
                                        indent: (size.width / 2) - 40,
                                        endIndent: (size.width / 2) - 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SpaceFixerHorizontalLine(
                        context: context,
                        overflowHeight: 3,
                        overflowColor: AppColors.primaryColor,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25),
                        height: size.height / 1.9,
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(50, 10, 50, 16),
                          child: Column(
                            children: [
                              Consumer<OnboardingProvider>(
                                builder: (context, value, child) =>
                                    TextFormField(
                                  autovalidateMode: value.autovalidateMode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return LocaleKeys.enterUsername.tr();
                                    }
                                    if (value.length <= 2) {
                                      return LocaleKeys.usernameShort.tr();
                                    }
                                    if (value.length > 26) {
                                      return LocaleKeys.usernameLong.tr();
                                    }
                                    bool usernameValid =
                                        RegExp(r'^[a-zA-Z0-9_]+$')
                                            .hasMatch(value);
                                    if (!usernameValid) {
                                      return LocaleKeys.usernameInvalid.tr();
                                    }
                                  },
                                  controller: _model.userNameController,
                                  focusNode: nameNode,
                                  autofocus: false,
                                  cursorColor: AppColors.primaryColor,
                                  autofillHints: [AutofillHints.name],
                                  obscureText: false,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(passNode);
                                  },
                                  decoration: InputDecoration(
                                    hintText: LocaleKeys.enterUsername.tr(),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE0E3E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF4B39EF),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors
                                          .white, // Set your desired color here
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.name,
                                  // validator: _model.emailAddressControllerValidator.asValidator(context),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<ModelProvider>(
                                builder: (context, value, child) =>
                                    Consumer<OnboardingProvider>(
                                  builder: (context, pass, child) =>
                                      TextFormField(
                                    autovalidateMode: pass.autovalidateMode,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LocaleKeys.enterPassword.tr();
                                      }
                                      if (value.length <= 5) {
                                        return LocaleKeys.passwordShort.tr();
                                      }
                                      if (value.length > 45) {
                                        return LocaleKeys.passwordLong.tr();
                                      }
                                    },
                                    obscureText:
                                        !value.model.passwordVisibility,
                                    controller: _model.passwordController,
                                    autofocus: false,
                                    autofillHints: [AutofillHints.password],
                                    focusNode: passNode,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.enterPassword.tr(),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF4B39EF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      errorStyle: TextStyle(
                                        color: Colors
                                            .white, // Set your desired color here
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF5963),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 20.0),
                                      suffixIcon: Consumer<ModelProvider>(
                                        builder: (context, value, child) =>
                                            InkWell(
                                          onTap: () {
                                            value.model.passwordVisibility
                                                ? value
                                                    .setFalse_PasswordVisible()
                                                : value
                                                    .setTrue_PasswordVisible();
                                          },
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Selector<ModelProvider,
                                              ModelProvider>(
                                            selector: (_, modelProvider) =>
                                                modelProvider,
                                            builder: (context, value, child) =>
                                                Icon(
                                              (value.model.passwordVisibility)
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xFF57636C),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                    ),

                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.name,
                                    // validator: _model
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Material(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                                child: Consumer<OnboardingProvider>(
                                  builder: (context, value, child) =>
                                      Consumer<UserProvider>(
                                    builder: (context, user, child) => InkWell(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );

                                        value.autovalidateModetrue();
                                        user.setUsername(
                                            userNameController.text);
                                        user.setPasswdor(
                                            passwordController.text);
                                        bool isLoginSuccess =
                                            await user.isLoginSuccess(
                                                user.username!, user.password!);
                                        final error = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: LocaleKeys.loginFaild.tr(),
                                            message: LocaleKeys
                                                .invaildUsernameOrPassword
                                                .tr(),
                                            contentType: ContentType.failure,
                                          ),
                                        );
                                        final success = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            height: 71,
                                            child: AwesomeSnackbarContent(
                                              title:
                                                  LocaleKeys.loginSuccess.tr(),
                                              message: ' ',
                                              contentType: ContentType.success,
                                            ),
                                          ),
                                        );
                                        if (!isLoginSuccess) {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(error);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(success);
                                        }
                                        Navigator.of(context).pop();
                                        // value.dispose();
                                        if (isLoginSuccess) {
                                          final SharedPreferences _preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (_preferences
                                              .getStringList(role)!
                                              .contains("student")) {
                                            Navigator.pushNamed(
                                                context, AppRouter.homeScreen);
                                          } else if (_preferences
                                              .getStringList(role)!
                                              .contains("busSupervisor")) {
                                            Navigator.pushNamed(context,
                                                AppRouter.homeScreenSup);
                                          }

                                          /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  homeScreen(),
                                            ),
                                          );*/
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          LocaleKeys.signIn.tr(),
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: AppColors.primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildImage({
    required Key? key,
    required String urlImage,
    required String title,
    required String subtitle,
    required Size size,
    // required Size size,
  }) =>
      ClipPath(
        clipper: ImageClipPathBetter(),
        child: Image(
          image: AssetImage(urlImage),
          fit: BoxFit.fitHeight,
          // height: size.height / 1.7,
          // width: size.width,
        ),
      );
}
