import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/custom_text_form_field.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/landing_screen/landing_screen_views.dart';

import 'cubit.dart';
import 'states.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: const _ChangePasswordBody(),
    );
  }
}

class _ChangePasswordBody extends StatelessWidget {
  const _ChangePasswordBody();

  @override
  Widget build(BuildContext context) {
    final cubit = ChangePasswordCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: cubit.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBarTitle(title: ""),
                CustomText(
                  text: "Change password",
                  color: ColorManager.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text:
                      "Don’t worry! It’s happens. Please enter your old and new password.",
                  color: ColorManager.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 5,
                ),
                SizedBox(height: 50.h),
                BlocBuilder<ChangePasswordCubit, ChangePasswordStates>(
                  builder: (context, state) {
                    return _CurrentPasswordTextField(
                      cubit: cubit,
                    );
                  },
                ),
                BlocBuilder<ChangePasswordCubit, ChangePasswordStates>(
                  builder: (context, state) {
                    return _NewPasswordTextField(
                      cubit: cubit,
                    );
                  },
                ),
                BlocBuilder<ChangePasswordCubit, ChangePasswordStates>(
                  builder: (context, state) {
                    return _ConfPassTextField(
                      cubit: cubit,
                    );
                  },
                ),
                SizedBox(height: 50.h),
                BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
                  listener: (context, state) {
                    if (state is ChangePasswordFailedState) {
                      showMessage(
                        message: state.msg,
                        color: ColorManager.red,
                      );
                    } else if (state is NetworkErrorState) {
                      showMessage(
                        message: "No internet connection",
                        color: ColorManager.red,
                      );
                    } else if (state is ChangePasswordSuccessState) {
                      showMessage(
                        message: "Password Updated Successfully",
                        color: ColorManager.green,
                      );
                      MagicRouter.navigateTo(page: const LandingScreenViews());
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordLoadingState) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: ColorManager.mainColor,
                      ));
                    }
                    return CustomElevated(
                      text: "Change",
                      press: () {
                        cubit.changePassword();
                      },
                      btnColor: ColorManager.mainColor,
                    );
                  },
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentPasswordTextField extends StatelessWidget {
  const _CurrentPasswordTextField({required this.cubit});

  final ChangePasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Old Password",
          color: ColorManager.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          controller: cubit.controllers.currentPasswordController,
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0197.sh),
            child: SvgIcon(
              icon: AssetsStrings.lock,
              height: 0.029.sh,
              color: ColorManager.white,
            ),
          ),
          hint: "Password..",
          validator: (value) {
            if (value.isEmpty) {
              return "Please Enter Old Password";
            }
            return null;
          },
          suffixIcon: SizedBox(
            height: 0.02.sh,
            child: GestureDetector(
              onTap: () {
                cubit.changeCurrentVisibility();
              },
              child: Icon(
                cubit.isCurrentObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: ColorManager.white,
              ),
            ),
          ),
          obscureText: cubit.isCurrentObscure,
          interactiveSelection: false,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

class _NewPasswordTextField extends StatelessWidget {
  const _NewPasswordTextField({required this.cubit});

  final ChangePasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "New Password",
          color: ColorManager.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          controller: cubit.controllers.newPasswordController,
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0197.sh),
            child: SvgIcon(
              icon: AssetsStrings.lock,
              height: 0.029.sh,
              color: ColorManager.white,
            ),
          ),
          hint: "Password..",
          validator: (value) {
            if (value.isEmpty) {
              return "Please Enter Password";
            } else if (value.length < 6) {
              return "Password must not be less than 6 characters!";
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
                color: ColorManager.white,
              ),
            ),
          ),
          obscureText: cubit.isObscure,
          interactiveSelection: false,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

class _ConfPassTextField extends StatelessWidget {
  const _ConfPassTextField({required this.cubit});

  final ChangePasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "New Password Confirmation",
          color: ColorManager.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          controller: cubit.controllers.confirmPasswordController,
          keyboardType: TextInputType.text,
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0197.sh),
            child: SvgIcon(
              icon: AssetsStrings.lock,
              height: 0.029.sh,
              color: ColorManager.white,
            ),
          ),
          hint: "Password..",
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Same Password !";
            } else if (value != cubit.controllers.newPasswordController.text) {
              return "Password Not the Same !";
            }
            return null;
          },
          suffixIcon: SizedBox(
            height: 0.02.sh,
            child: GestureDetector(
              onTap: () {
                cubit.conChangeVisibility();
              },
              child: Icon(
                cubit.isConObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: ColorManager.white,
              ),
            ),
          ),
          obscureText: cubit.isConObscure,
          interactiveSelection: false,
          isLastInput: true,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
