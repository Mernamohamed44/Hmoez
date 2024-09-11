import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/features/landing_screen/landing_screen_views.dart';
import 'package:homez/features/login/view.dart';
import 'package:homez/features/reset_password/view.dart';

import 'components/pinput.dart';
import 'cubit.dart';
import 'states.dart';

class OtpView extends StatelessWidget {
  const OtpView(
      {super.key,
      required this.phone,
      this.navigateFromForget = false,
      this.navigateFromProfile = false});

  final String phone;
  final bool navigateFromForget;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: _OtpBody(
        phone: phone,
        navigateFromForget: navigateFromForget,
        navigateFromProfile: navigateFromProfile,
      ),
    );
  }
}

class _OtpBody extends StatelessWidget {
  const _OtpBody({
    required this.phone,
    required this.navigateFromForget,
    required this.navigateFromProfile,
  });

  final bool navigateFromForget;
  final String phone;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    final otpCubit = context.read<OtpCubit>();
    otpCubit.otpController.clear();

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBarTitle(title: "Verification Code"),
              SizedBox(height: 16.h),
              CustomText(
                text: "Enter the Verification Code.",
                color: ColorManager.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              ),
              CustomText(
                text: "We have sent a verification code to your email.",
                color: ColorManager.grey10,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              ),
              PinPutWidget(
                controller: otpCubit.otpController,
              ),
              _VerifyOtpButton(
                otpCubit: otpCubit,
                phone: phone,
                navigateFromForget: navigateFromForget,
                navigateFromProfile: navigateFromProfile,
              ),
              SizedBox(height: 0.04.sh),
              _ResendLineWidget(
                otpCubit: otpCubit,
                phone: phone,
              ),
              SizedBox(height: 0.2.sh),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerifyOtpButton extends StatelessWidget {
  const _VerifyOtpButton(
      {required this.otpCubit,
      required this.phone,
      required this.navigateFromForget,
      required this.navigateFromProfile});

  final OtpCubit otpCubit;
  final String phone;
  final bool navigateFromForget;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listener: (context, state) {
        if (state is OtpFailureState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is OtpSuccessState) {
          if (navigateFromProfile) {
            showMessage(
              message: "Phone Updated Successfully",
              color: ColorManager.green,
            );
            MagicRouter.navigateReplacement(
              page: const LandingScreenViews(),
            );
          } else {
            navigateFromForget
                ? MagicRouter.navigateReplacement(
                    page: ResetPasswordView(
                      phone: phone,
                      otp: otpCubit.otpController.text,
                    ),
                  )
                : MagicRouter.navigateReplacement(
                    page: const LoginView(),
                  );
          }
        }
      },
      builder: (context, state) {
        if (state is OtpLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        return CustomElevated(
          text: "Continue",
          press: () {
            if (otpCubit.otpController.text.length != 4) {
              showMessage(
                message: "please enter code",
                color: ColorManager.red,
              );
            } else {
              if (navigateFromProfile) {
                otpCubit.updatePhone(phone: phone);
              } else {
                navigateFromForget
                    ? otpCubit.checkCode(phone: phone)
                    : otpCubit.confirmCode(
                        phone: phone,
                      );
              }
            }
          },
          btnColor: ColorManager.mainColor,
        );
      },
    );
  }
}

class _ResendLineWidget extends StatelessWidget {
  const _ResendLineWidget(
      {super.key, required this.otpCubit, required this.phone});

  final OtpCubit otpCubit;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listener: (context, state) {
        if (state is ReSendCodeFailedState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is ReSendCodeSuccessState) {}
      },
      builder: (context, state) {
        if (state is ReSendCodeLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "If you didn’t receive the code?  ",
              style: TextStyle(
                color: ColorManager.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "Resend",
                  style: TextStyle(
                    color: ColorManager.mainColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      debugPrint("resend");
                      otpCubit.reSendOtp(phone: phone);
                    },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
