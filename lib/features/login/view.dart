import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/custom_text_form_field.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/forget_password/forget_pass_view.dart';
import 'package:homez/features/landing_screen/landing_screen_views.dart';

import 'components/or_divider.dart';
import 'components/register_line.dart';
import 'cubit.dart';
import 'states.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Form(
        key: cubit.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0.06.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.h),
                Padding(
                  padding: EdgeInsets.only(right: 0.2.sw),
                  child: CustomText(
                    text: "Welcome to Homz",
                    color: ColorManager.white,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w800,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 30.h),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return _PhoneTextField(cubit: cubit);
                  },
                ),
                SizedBox(height: 0.03.sh),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return _PasswordTextField(cubit: cubit);
                  },
                ),
                SizedBox(height: 0.01.sh),
                _ForgetPasswordWidget(
                  cubit: cubit,
                ),
                SizedBox(height: 0.03.sh),
                _LoginButton(cubit: cubit),
                SizedBox(height: 0.027.sh),
                const Center(child: RegisterLineWidget()),
                SizedBox(height: 0.027.sh),
                _OrLineWithAuthGoogle(
                  cubit: cubit,
                ),
                SizedBox(height: 0.15.sh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  const _PhoneTextField({required this.cubit});

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: cubit.controllers.phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0197.sh),
        child: SvgIcon(
          icon: AssetsStrings.phone,
          height: 0.029.sh,
          color: ColorManager.grey10,
        ),
      ),
      hint: "Mobile Number",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Mobile Number !";
        }
        return null;
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({required this.cubit});

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: cubit.controllers.passwordController,
      keyboardType: TextInputType.text,
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0197.sh),
        child: SvgIcon(
          icon: AssetsStrings.lock,
          height: 0.029.sh,
          color: ColorManager.grey10,
        ),
      ),
      hint: "Password",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your password !";
        }
        return null;
      },
      suffixIcon: SizedBox(
        height: 0.02.sh,
        child: GestureDetector(
          onTap: () {
            cubit.changeVisibility();
          },
          child: Icon(
            cubit.isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: ColorManager.grey10,
          ),
        ),
      ),
      obscureText: cubit.isObscure,
      interactiveSelection: false,
      isLastInput: true,
    );
  }
}

class _ForgetPasswordWidget extends StatelessWidget {
  const _ForgetPasswordWidget({required this.cubit});

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10.w),
            TextButton(
              onPressed: () {
                MagicRouter.navigateTo(
                  page: ForgetPasswordViews(
                    phone: cubit.controllers.phoneController.text,
                  ),
                );
              },
              child: CustomText(
                text: "Forget Password?",
                color: ColorManager.mainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.cubit});

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginFailedState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is NetworkErrorState) {
          showMessage(
            message: "No internet connection",
            color: ColorManager.red,
          );
        } else if (state is LoginSuccessState) {
          MagicRouter.navigateTo(
            page: const LandingScreenViews(),
            withHistory: false,
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        return CustomElevated(
          text: "Sign In",
          press: () {
            cubit.login();
          },
          btnColor: ColorManager.mainColor,
        );
      },
    );
  }
}

class _OrLineWithAuthGoogle extends StatelessWidget {
  const _OrLineWithAuthGoogle({required this.cubit});

  final LoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDividerWidget(),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LoginCubit, LoginStates>(
              listener: (context, state) {
                if (state is SignInWithGoogleFailedState) {
                  showMessage(
                    message: state.msg,
                    color: ColorManager.red,
                  );
                } else if (state is NetworkErrorState) {
                  showMessage(
                    message: "No internet connection",
                    color: ColorManager.red,
                  );
                } else if (state is SignInWithGoogleSuccessState) {
                  MagicRouter.navigateTo(
                    page: const LandingScreenViews(),
                    withHistory: false,
                  );
                }
              },
              builder: (context, state) {
                if (state is SignInWithGoogleLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.mainColor,
                    ),
                  );
                }
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      cubit.signInWithGoogle();
                    },
                    child: SvgPicture.asset(
                      AssetsStrings.google,
                      height: 60.h,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
              if (state is SignInWithAppleFailedState) {
                showMessage(
                  message: state.msg,
                  color: ColorManager.red,
                );
              } else if (state is NetworkErrorState) {
                showMessage(
                  message: "No internet connection",
                  color: ColorManager.red,
                );
              } else if (state is SignInWithAppleSuccessState) {
                MagicRouter.navigateTo(
                  page: const LandingScreenViews(),
                  withHistory: false,
                );
              }
            }, builder: (context, state) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.signInWithApple();
                  },
                  child: SvgPicture.asset(
                    AssetsStrings.apple,
                    height: 60.h,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
