import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text_form_field.dart';
import 'package:homez/core/widgets/snack_bar.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/otp/view.dart';
import 'package:homez/features/profile_details/profile_details_cubit.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView(
      {super.key,
      required this.fullName,
      required this.phone,
      this.navigateFromProfile = false});

  final String fullName;
  final String phone;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileDetailsCubit(),
      child: ProfileDetailsBody(
        fullName: fullName,
        phone: phone,
        navigateFromProfile: navigateFromProfile,
      ),
    );
  }
}

class ProfileDetailsBody extends StatelessWidget {
  const ProfileDetailsBody({
    super.key,
    required this.fullName,
    required this.phone,
    required this.navigateFromProfile,
  });

  final String fullName;
  final String phone;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileDetailsCubit>(context);
    cubit.controllers.nameController.text = fullName;
    cubit.controllers.phoneController.text = phone;
    return Scaffold(
      body: Form(
        key: cubit.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              const CustomAppBarTitle(
                title: "Account Details",
                withBack: true,
              ),
              30.verticalSpace,
              _NameTextField(
                cubit: cubit,
              ),
              SizedBox(height: 32.h),
              _PhoneTextField(
                cubit: cubit,
              ),
              // SizedBox(height: 32.h),
              // BlocBuilder<ProfileDetailsCubit, ProfileDetailsState>(
              //   builder: (context, state) {
              //     return _PasswordTextField(cubit: cubit,);
              //   },
              // ),
              SizedBox(height: 32.h),
              _SaverButton(
                cubit: cubit,
                fullName: fullName,
                navigateFromProfile: navigateFromProfile,
              )
            ],
          ),
        ),
      ),
      backgroundColor: ColorManager.bgColor,
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({required this.cubit});

  final ProfileDetailsCubit cubit;

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

  final ProfileDetailsCubit cubit;

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

  final ProfileDetailsCubit cubit;

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

class _SaverButton extends StatelessWidget {
  const _SaverButton(
      {required this.cubit,
      required this.fullName,
      required this.navigateFromProfile});

  final ProfileDetailsCubit cubit;
  final String fullName;
  final bool navigateFromProfile;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileDetailsCubit, ProfileDetailsState>(
      listener: (context, state) {
        if (state is UpdateProfileFailedState) {
          showMessage(
            message: state.msg,
            color: ColorManager.red,
          );
        } else if (state is NetworkErrorState) {
          showMessage(
            message: "No internet connection",
            color: ColorManager.red,
          );
        } else if (state is UpdateProfileSuccessState) {
          showMessage(
            message: "Profile Updated Successfully",
            color: ColorManager.green,
          );
          MagicRouter.navigatePop();
        } else if (state is UpdatePhoneSuccessState) {
          MagicRouter.navigateTo(
              page: OtpView(
            phone: cubit.controllers.phoneController.text,
            navigateFromProfile: true,
          ));
        }
      },
      builder: (context, state) {
        if (state is UpdateProfileLoadingState) {
          return CircularProgressIndicator(
            color: ColorManager.mainColor,
          );
        } else if (state is UpdatePhoneLoadingState) {
          return CircularProgressIndicator(
            color: ColorManager.mainColor,
          );
        }
        return CustomElevated(
          text: "Save",
          press: () {
            fullName != cubit.controllers.phoneController.text
                ? cubit.updatePhone()
                : cubit.updateProfile();
          },
          btnColor: ColorManager.mainColor,
        );
      },
    );
  }
}
