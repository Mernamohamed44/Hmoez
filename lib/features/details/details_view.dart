import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_app_bar.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/details/widgets/icon_text.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DetailsBody();
  }
}

class _DetailsBody extends StatelessWidget {
  const _DetailsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
            child: CustomAppBarTitle(
              title: "Apartment Details",
              color: ColorManager.bgColor,
            ),
          ),
          30.verticalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.r),
                ),
                color: ColorManager.black2,
              ),
              child: Column(
                children: [
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Lakotle House",
                        color: ColorManager.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        text: "\$500,000",
                        color: ColorManager.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 0.4.sh,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              AssetsStrings.detailsImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: ColorManager.mainColor,
                            child: SvgIcon(
                              icon: AssetsStrings.send,
                              color: ColorManager.white,
                              height: 25,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: ColorManager.white,
                              backgroundColor: ColorManager.mainColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: CustomText(
                                text: "Take a Look",
                                color: ColorManager.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Colonial Jolliya",
                              color: ColorManager.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text: "450 Elm Avenue, Jolliya, NY 122",
                              color: ColorManager.grey10,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      SvgIcon(
                        icon: AssetsStrings.heart,
                        color: ColorManager.white,
                        height: 25,
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  const Row(
                    children: [
                      Expanded(
                        child: RowIconTextWidget(
                          icon: AssetsStrings.bath,
                          text: "4 Bath",
                        ),
                      ),
                      Expanded(
                        child: RowIconTextWidget(
                          icon: AssetsStrings.bed,
                          text: "5 Beds",
                        ),
                      ),
                      Expanded(
                        child: RowIconTextWidget(
                          icon: AssetsStrings.widget,
                          text: "450m",
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: CustomText(
                      text:
                          "Immaculately Renovated Townhouse In Prime Williamsburg Located at the heart of Jolliya’s coveted  neighborhood. 180 powers street",
                      color: ColorManager.grey10,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLines: 3,
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevated(
                          text: "Call",
                          press: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomElevated(
                                      text: "Call +12497035372",
                                      press: () {},
                                      btnColor: ColorManager.grey11,
                                      textColor: ColorManager.secMain2Color,
                                      borderRadius: 8.r,
                                    ),
                                    10.verticalSpace,
                                    CustomElevated(
                                      text: "Cancel ",
                                      press: () {},
                                      btnColor: ColorManager.grey11,
                                      textColor: ColorManager.secMain2Color,
                                      borderRadius: 8.r,
                                    ),
                                    65.verticalSpace,
                                  ],
                                ),
                              ),
                            );
                          },
                          btnColor: ColorManager.mainColor,
                        ),
                      ),
                      15.horizontalSpace,
                      Expanded(
                        child: CustomElevated(
                          text: "Message",
                          press: () {},
                          btnColor: ColorManager.mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
