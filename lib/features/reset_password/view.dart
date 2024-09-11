import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/custom_text_form_field.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/core/widgets/svg_icons.dart';

import 'cubit.dart';
import 'states.dart';
import 'widgets/success_dialog.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.phone, required this.otp});

  final String phone;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResetPasswordCubit(),
      child: _ResetPasswordBody(
        phone: phone,
        otp: otp,
      ),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody({required this.phone, required this.otp});

  final String phone;
  final String otp;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
        child: Form(
          key: cubit.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBarTitle(title: "Reset Password"),
                SizedBox(height: 16.h),
                CustomText(
                  text: "Enter New Password.",
                  color: ColorManager.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
                CustomText(
                  text: "Your new password must be strong.",
                  color: ColorManager.grey10,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
                SizedBox(height: 0.04.sh),
                BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
                  builder: (context, state) {
                    return _PasswordTextField(
                      cubit: cubit,
                    );
                  },
                ),
                SizedBox(height: 0.02.sh),
                BlocBuilder<ResetPasswordCubit, ResetPasswordStates>(
                  builder: (context, state) {
                    return _ConfPassTextField(
                      cubit: cubit,
                    );
                  },
                ),
                SizedBox(height: 0.05.sh),
                _ResetPasswordButton(
                  cubit: cubit,
                  phone: phone,
                  otp: otp,
                ),
                SizedBox(height: 0.2.sh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({required this.cubit});

  final ResetPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: cubit.controllers.passwordController,
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0197.sh),
        child: SvgIcon(
          icon: AssetsStrings.lock,
          height: 0.029.sh,
          color: ColorManager.grey10,
        ),
      ),
      hint: "password",
      validator: (value) {
        if (value.isEmpty) {
          return "enter_password";
        } else if (value.length < 6) {
          return "enter_6_password";
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
    );
  }
}

class _ConfPassTextField extends StatelessWidget {
  const _ConfPassTextField({
    required this.cubit,
  });

  final ResetPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: cubit.controllers.confirmPasswordController,
      keyboardType: TextInputType.text,
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0197.sh),
        child: SvgIcon(
          icon: AssetsStrings.lock,
          height: 0.029.sh,
          color: ColorManager.grey10,
        ),
      ),
      hint: "confirm password",
      validator: (value) {
        if (value!.isEmpty) {
          return "enter_same_pass";
        } else if (value != cubit.controllers.passwordController.text) {
          return "pass_not_same";
        }
        return null;
      },
      suffixIcon: SizedBox(
        height: 0.02.sh,
        child: IconButton(
          onPressed: () {
            cubit.conChangeVisibility();
          },
          icon: Icon(
            cubit.isConObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: ColorManager.grey10,
          ),
        ),
      ),
      obscureText: cubit.isConObscure,
      interactiveSelection: false,
      isLastInput: true,
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton({
    required this.cubit,
    required this.phone,
    required this.otp,
  });

  final ResetPasswordCubit cubit;
  final String phone;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
      listener: (context, state) {
        if (state is ResetPasswordFailedState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is NetworkErrorState) {
          showMessage(
            message: "check_network",
            color: ColorManager.red,
          );
        } else if (state is ResetPasswordSuccessState) {
          successDialog(context: context);
        }
      },
      builder: (context, state) {
        if (state is ResetPasswordLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        return CustomElevated(
          text: "Reset Password",
          press: () {
            cubit.resetPassword(phone: phone, otp: otp);
          },
          btnColor: ColorManager.mainColor,
        );
      },
    );
  }
}
