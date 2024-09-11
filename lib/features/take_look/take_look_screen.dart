import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homez/core/helpers/navigator.dart';
import 'package:homez/core/theming/assets.dart';
import 'package:homez/core/theming/colors.dart';
import 'package:homez/core/widgets/custom_text.dart';
import 'package:homez/core/widgets/svg_icons.dart';
import 'package:homez/features/take_look/SweetNavBar/src/sweet_nav_bar.dart';
import 'package:story_view/story_view.dart';

class TakeLookScreen extends StatelessWidget {
  const TakeLookScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return const TakeLookBody(
      isResidential: true,
      isShops: false,
    );
  }
}

class TakeLookBody extends StatefulWidget {
  const TakeLookBody({
    super.key,
    required this.isResidential,
    required this.isShops,
  });

  final bool isResidential;
  final bool isShops;

  @override
  _TakeLookBodyState createState() => _TakeLookBodyState();
}

class _TakeLookBodyState extends State<TakeLookBody> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  int cIndex = 0;
  final iconLinearGradiant = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80)
  ]);

  @override
  Widget build(BuildContext context) {
    storyItem({required String image}) {
      return StoryItem.pageImage(
        imageFit: BoxFit.fill,
        url: image,
        // caption: const Text(
        //   "Still sampling",
        //   style: TextStyle(
        //     fontSize: 15,
        //     color: Colors.white,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        controller: storyController,
      );
    }

    List<StoryItem> storyItemList = [
      storyItem(
          image:
              'https://res.cloudinary.com/castlery/image/private/f_auto,q_auto:best/b_rgb:FFFFFF,c_fit/v1683796668/crusader/variants/50441135-CB4001/Auburn-Performance-Boucle-Extended-L-Shape-Sectional-Sofa-Chalk-Square-Set_5-1683796666.jpg'),
      storyItem(
          image:
              'https://res.cloudinary.com/castlery/image/private/f_auto,q_auto:best/b_rgb:FFFFFF,c_fit/v1684314831/crusader/variants/T50441135-CB4001/Auburn-Performance-Boucle-Curve-3-Seater-Sofa-Chalk-Square-Det_2-1684314831.jpg'),
      storyItem(
          image:
              'https://res.cloudinary.com/castlery/image/private/f_auto,q_auto:best/b_rgb:FFFFFF,c_fit/v1683795327/crusader/variants/50441135-CB4001/Auburn-Performance-Boucle-Extended-L-Shape-Sectional-Sofa-Chalk-Side-1683795325.jpg'),
      storyItem(
          image:
              'https://res.cloudinary.com/castlery/image/private/f_auto,q_auto:best/b_rgb:FFFFFF,c_fit/v1683796668/crusader/variants/50441135-CB4001/Auburn-Performance-Boucle-Extended-L-Shape-Sectional-Sofa-Chalk-Square-Set_5-1683796666.jpg'),
      storyItem(
          image:
              'https://res.cloudinary.com/castlery/image/private/f_auto,q_auto:best/b_rgb:FFFFFF,c_fit/v1684314831/crusader/variants/T50441135-CB4001/Auburn-Performance-Boucle-Curve-3-Seater-Sofa-Chalk-Square-Det_2-1684314831.jpg'),
    ];
    return Scaffold(
      body: Stack(children: [
        StoryView(
          storyItems: storyItemList,
          onStoryShow: (storyItem, index) {
            print("Showing a story");
          },
          onComplete: () {
            print("Completed a cycle");
          },
          progressPosition: ProgressPosition.top,
          indicatorColor: Colors.black,
          indicatorHeight: IndicatorHeight.small,
          indicatorOuterPadding: const EdgeInsets.all(16),
          repeat: true,
          controller: storyController,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 80.h),
          child: GestureDetector(
            onTap: () {
              MagicRouter.navigatePop();
            },
            child: CircleAvatar(
                radius: 26,
                backgroundColor: ColorManager.black,
                child: const SvgIcon(
                    height: 40, icon: AssetsStrings.back, color: Colors.white)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                          text: 'Araay',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp),
                      CustomText(
                          text: 'Apartments',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp),
                      CustomText(
                          text: '\$70,500',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                          radius: 26,
                          backgroundColor: widget.isShops
                              ? Colors.black
                              : ColorManager.blueColor,
                          child: const SvgIcon(
                              height: 25,
                              icon: AssetsStrings.send,
                              color: Colors.white)),
                      8.verticalSpace,
                      CircleAvatar(
                          radius: 26,
                          backgroundColor: widget.isShops
                              ? Colors.black
                              : ColorManager.blueColor,
                          child: const SvgIcon(
                              height: 25,
                              icon: AssetsStrings.phone,
                              color: Colors.white,),),
                    ],
                  )
                ],
              ),
              // SizedBox(
              //   height: 24.h
              // ),
              // widget.isResidential
              //     ? SweetNavBar(
              //         backgroundColor: Colors.white,
              //         showSelectedLabels: true,
              //         showUnselectedLabels: true,
              //         currentIndex: cIndex,
              //         items: [
              //           SweetNavBarItem(
              //             isGradient: false,
              //             sweetActive: CircleAvatar(
              //                 radius: 26,
              //                 backgroundColor: ColorManager.blueColor,
              //                 child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.bath,
              //                     color: Colors.white)),
              //             sweetIcon: CircleAvatar(
              //                 radius: 26,
              //                 backgroundColor: ColorManager.blueColor,
              //                 child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.bath,
              //                     color: Colors.white)),
              //             sweetLabel: 'BathRoom',
              //           ),
              //           SweetNavBarItem(
              //             isGradient: false,
              //             sweetActive: CircleAvatar(
              //                 radius: 26,
              //                 backgroundColor: ColorManager.blueColor,
              //                 child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.bed,
              //                     color: Colors.white)),
              //             sweetIcon: CircleAvatar(
              //                 radius: 26,
              //                 backgroundColor: ColorManager.blueColor,
              //                 child: const SvgIcon(
              //                   height: 23,
              //                   icon: AssetsStrings.bed,
              //                   color: Colors.white,
              //                 )),
              //             sweetLabel: 'Office',
              //           ),
              //           SweetNavBarItem(
              //             isGradient: false,
              //             sweetActive: CircleAvatar(
              //                 radius: 26,
              //                 backgroundColor: ColorManager.blueColor,
              //                 child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.car,
              //                     color: Colors.white)),
              //             sweetIcon: CircleAvatar(
              //               radius: 26,
              //               backgroundColor: ColorManager.blueColor,
              //               child: const SvgIcon(
              //                 height: 23,
              //                 icon: AssetsStrings.car,
              //                 color: Colors.white,
              //               ),
              //             ),
              //             sweetLabel: 'Parking ',
              //           ),
              //           SweetNavBarItem(
              //             isGradient: false,
              //             sweetActive: CircleAvatar(
              //               radius: 26,
              //               backgroundColor: ColorManager.blueColor,
              //               child: const SvgIcon(
              //                 height: 18,
              //                 icon: AssetsStrings.gym,
              //                 color: Colors.white,
              //               ),
              //             ),
              //             sweetIcon: CircleAvatar(
              //               radius: 26,
              //               backgroundColor: ColorManager.blueColor,
              //               child: const SvgIcon(
              //                 height: 18,
              //                 icon: AssetsStrings.gym,
              //                 color: Colors.white,
              //               ),
              //             ),
              //             sweetLabel: 'Gym ',
              //           )
              //         ],
              //         onTap: (index) {
              //           setState(() {
              //             cIndex = index;
              //           });
              //         },
              //       )
              //     : widget.isShops
              //         ? const SizedBox.shrink()
              //         : SweetNavBar(
              //             backgroundColor: Colors.white,
              //             showSelectedLabels: true,
              //             showUnselectedLabels: true,
              //             currentIndex: cIndex,
              //             items: [
              //               SweetNavBarItem(
              //                 isGradient: false,
              //                 sweetActive: CircleAvatar(
              //                     radius: 26,
              //                     backgroundColor: ColorManager.blueColor,
              //                     child: const SvgIcon(
              //                         height: 23,
              //                         icon: AssetsStrings.bath,
              //                         color: Colors.white)),
              //                 sweetIcon: CircleAvatar(
              //                   radius: 26,
              //                   backgroundColor: ColorManager.blueColor,
              //                   child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.bath,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 sweetLabel: 'BathRoom',
              //               ),
              //               SweetNavBarItem(
              //                 isGradient: false,
              //                 sweetActive: CircleAvatar(
              //                     radius: 26,
              //                     backgroundColor: ColorManager.blueColor,
              //                     child: const SvgIcon(
              //                         height: 23,
              //                         icon: AssetsStrings.bed,
              //                         color: Colors.white)),
              //                 sweetIcon: CircleAvatar(
              //                   radius: 26,
              //                   backgroundColor: ColorManager.blueColor,
              //                   child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.bed,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 sweetLabel: 'Office',
              //               ),
              //               SweetNavBarItem(
              //                 isGradient: false,
              //                 sweetActive: CircleAvatar(
              //                   radius: 26,
              //                   backgroundColor: ColorManager.blueColor,
              //                   child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.car,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 sweetIcon: CircleAvatar(
              //                   radius: 26,
              //                   backgroundColor: ColorManager.blueColor,
              //                   child: const SvgIcon(
              //                     height: 23,
              //                     icon: AssetsStrings.car,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 sweetLabel: 'Parking ',
              //               ),
              //             ],
              //             onTap: (index) {
              //               setState(() {
              //                 cIndex = index;
              //               });
              //             },
              //           ),
            ],
          ),
        )
      ]),
    );
  }
}
