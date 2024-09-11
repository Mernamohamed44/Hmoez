import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_text.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({
    super.key,
    required this.title,
    this.color,
    this.withBack = true,
  });

  final String title;
  final Color? color;
  final bool withBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, bottom: 30.h),
      child: Row(
        children: [
          withBack
              ? GestureDetector(
                  onTap: () {
                    MagicRouter.navigatePop();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      AssetsStrings.back,
                      height: 30.h,
                      color: color ?? ColorManager.white,
                    ),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          CustomText(
            text: title,
            color: color ?? ColorManager.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
          const Spacer(),
          SizedBox(width: 30.w),
        ],
      ),
    );
  }
}
