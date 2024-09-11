import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/features/login/view.dart';

successDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorManager.black,
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AssetsStrings.successImage,
                height: 0.25.sh,
              ),
              SizedBox(height: 20.h),
              Center(
                child: FittedBox(
                  child: CustomText(
                    text: "Congratulations!",
                    color: ColorManager.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: "Your password has been successfully updated",
                color: ColorManager.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              CustomElevated(
                text: "Continue",
                press: () {
                  MagicRouter.navigateTo(page: LoginView(), withHistory: false);
                },
                btnColor: ColorManager.mainColor,
              ),
            ],
          ),
        ),
      );
    },
  );
}
