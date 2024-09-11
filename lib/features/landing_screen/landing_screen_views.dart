import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/features/landing_screen/landing_screen_cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LandingScreenViews extends StatelessWidget {
  const LandingScreenViews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingScreenCubit(),
      child: LandingBody(),
    );
  }
}

class LandingBody extends StatelessWidget {
  const LandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LandingScreenCubit>(context);
    return BlocBuilder<LandingScreenCubit, LandingScreenState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.bgColor,
          body: cubit.getCurrentView,
          bottomNavigationBar: SalomonBottomBar(
              selectedColorOpacity: 1,
              // unselectedItemColor: ,
              selectedItemColor: ColorManager.blueColor,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavigationBottom(index);
              },
              items: cubit.bottomNavigationItems),
        );
      },
    );
  }
}
