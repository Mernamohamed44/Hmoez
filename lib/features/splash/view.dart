import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/cache_helper.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/features/landing_screen/landing_screen_views.dart';
import 'package:homez/features/login/view.dart';
import 'package:homez/features/on_boarding/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() async {
    bool isFirstTime = CacheHelper.getIfFirstTime();
    String token = CacheHelper.getToken();

    await Future.delayed(
      const Duration(seconds: 5),
      () {
        MagicRouter.navigateTo(
          page: isFirstTime
              ? const OnBoardingView()
              : token.isEmpty
                  ? const LoginView()
                  : const LandingScreenViews(),
          withHistory: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsStrings.splashBg),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
