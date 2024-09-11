import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text_form_field.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/landing_screen/landing_screen_views.dart';
import 'package:homez/features/login/components/or_divider.dart';
import 'package:homez/features/otp/view.dart';

import 'cubit.dart';
import 'states.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const _RegisterBody(),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: Form(
        key: cubit.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBarTitle(title: "Create Account"),
                SizedBox(height: 16.h),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return _NameTextField(cubit: cubit);
                  },
                ),
                SizedBox(height: 0.02.sh),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return _PhoneTextField(cubit: cubit);
                  },
                ),
                SizedBox(height: 0.02.sh),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return _PasswordTextField(cubit: cubit);
                  },
                ),
                SizedBox(height: 0.02.sh),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (context, state) {
                    return _ConfPassTextField(
                      cubit: cubit,
                    );
                  },
                ),
                SizedBox(height: 0.04.sh),
                _RegisterButton(cubit: cubit),
                SizedBox(height: 0.15.sh),
                _OrLineWithAuthGoogle(
                  cubit: cubit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({required this.cubit});

  final RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: cubit.controllers.nameController,
      prefixIcon: Padding(
        padding: EdgeInsets.all(0.0197.sh),
        child: SvgIcon(
          icon: AssetsStrings.user,
          height: 0.029.sh,
          color: ColorManager.grey10,
        ),
      ),
      hint: "Name",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Name !";
        }
        return null;
      },
    );
  }
}

class _PhoneTextField extends StatelessWidget {
  const _PhoneTextField({required this.cubit});

  final RegisterCubit cubit;

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

  final RegisterCubit cubit;

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
        if (value.isEmpty) {
          return "Please Enter your Password";
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

class _ConfPassTextField extends StatelessWidget {
  const _ConfPassTextField({
    required this.cubit,
  });

  final RegisterCubit cubit;

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
      hint: "Confirm Password",
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Same Pass";
        } else if (value != cubit.controllers.passwordController.text) {
          return "Pass Not Same";
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.cubit});

  final RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterFailedState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is RegisterNetworkErrorState) {
          showMessage(
            message: "No internet connection",
            color: ColorManager.red,
          );
        } else if (state is RegisterSuccessState) {
          MagicRouter.navigateTo(
            page: OtpView(
              phone: cubit.controllers.phoneController.text,
            ),
            withHistory: false,
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
          );
        }
        return CustomElevated(
          text: "Sign Up",
          press: () {
            cubit.register();
            // MagicRouter.navigateTo(
            //   page: const NavBarView(),
            //   withHistory: false,
            // );
          },
          btnColor: ColorManager.mainColor,
        );
      },
    );
  }
}

class _OrLineWithAuthGoogle extends StatelessWidget {
  const _OrLineWithAuthGoogle({required this.cubit});

  final RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDividerWidget(),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<RegisterCubit, RegisterStates>(
              listener: (context, state) {
                if (state is RegisterWithGoogleFailedState) {
                  showMessage(
                    message: state.msg,
                    color: ColorManager.red,
                  );
                } else if (state is RegisterNetworkErrorState) {
                  showMessage(
                    message: "No internet connection",
                    color: ColorManager.red,
                  );
                } else if (state is RegisterWithGoogleSuccessState) {
                  MagicRouter.navigateTo(
                    page: const LandingScreenViews(),
                    withHistory: false,
                  );
                }
              },
              builder: (context, state) {
                if (state is RegisterWithGoogleLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.mainColor,
                    ),
                  );
                }
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      cubit.registerWithGoogle();
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
            BlocConsumer<RegisterCubit, RegisterStates>(
                listener: (context, state) {
              if (state is RegisterWithAppleFailedState) {
                showMessage(
                  message: state.msg,
                  color: ColorManager.red,
                );
              } else if (state is RegisterNetworkErrorState) {
                showMessage(
                  message: "No internet connection",
                  color: ColorManager.red,
                );
              } else if (state is RegisterWithAppleSuccessState) {
                MagicRouter.navigateTo(
                  page: const LandingScreenViews(),
                  withHistory: false,
                );
              }
            }, builder: (context, state) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.registerWithApple();
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
