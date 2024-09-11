import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_elevated.dart';
import 'package:homez/core/widgets/custom_tab_bar.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/take_look/take_look_screen.dart';

import '../models.dart';

class MainTabsWithBody extends StatelessWidget {
  const MainTabsWithBody({super.key, required this.homeData});

  final Data homeData;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: homeData.apartmentTypes!.length,
      child: Column(
        children: [
          CustomTabBar(
            tabs: List.generate(
              homeData.apartmentTypes!.length,
              (index) {
                final apartmentType = homeData.apartmentTypes![index];
                return CustomText(
                  text: "${apartmentType.name}",
                  color: ColorManager.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                );
              },
            ),
            isScrollable: false,
          ),
          // CustomBuyWidget(
          //   pages: homeData.apartments!,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: SizedBox(
              height: 0.6.sh,
              child: Swiper(
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Image.network(
                          "${homeData.apartments![index].mainImage}",
                          fit: BoxFit.cover,
                          height: 0.6.sh,
                        ),
                        Positioned(
                          right: 18,
                          bottom: 20,
                          child:  Row(
                            children: [
                              SizedBox(
                                height: 38.h,
                                width: 141.w,
                                child: CustomElevated(
                                  borderRadius: 8.sp,
                                  text: "Take a Look ",
                                  press: () {
                                    print("${homeData.apartments![index].id}");
                                    // MagicRouter.navigateTo(
                                    //   page: TakeLookScreen(
                                    //     id: "${homeData.apartments![index].id}",
                                    //   ),
                                    // );
                                  },
                                  btnColor: ColorManager.mainColor,
                                ),
                              ),
                              8.horizontalSpace,
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorManager.blueColor,
                                child: const SvgIcon(
                                  icon: AssetsStrings.out,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                         const Positioned(
                          right: 25,
                          top: 30,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: SvgIcon(
                              icon: AssetsStrings.favorite,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: homeData.apartments!.length,
                itemWidth: 0.8.sw,
                layout: SwiperLayout.STACK,
                // loop: false,
                // autoplay: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
