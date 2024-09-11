// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:homez/core/helpers/navigator.dart';
// import 'package:homez/core/theming/assets.dart';
// import 'package:homez/core/theming/colors.dart';
// import 'package:homez/core/widgets/custom_elevated.dart';
// import 'package:homez/core/widgets/svg_icons.dart';
// import 'package:homez/features/home/models.dart';
// import 'package:homez/features/take_look/take_look_screen.dart';
//
// class CustomBuyWidget extends StatefulWidget {
//   const CustomBuyWidget({
//     super.key,
//     required this.pages,
//   });
//
//   final List<Apartments> pages;
//
//   @override
//   State<CustomBuyWidget> createState() => _CustomBuyWidgetState();
// }
//
// class _CustomBuyWidgetState extends State<CustomBuyWidget> {
//   late PageController _pageController;
//   double _currentPage = 10;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 10);
//     _pageController.addListener(() {
//       setState(() {
//         _currentPage = _pageController.page!;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return Center(
//       child: SizedBox(
//         height: 0.6.sh,
//         child: Stack(
//           children: [
//             SizedBox(
//               child: LayoutBuilder(
//                 builder: (context, boxConstraints) {
//                   List<Widget> cards = [];
//
//                   for (int i = 0; i < widget.pages.length; i++) {
//                     double currentPageValue = i - _currentPage;
//                     bool pageLocation = currentPageValue > 0;
//
//                     double start = 50 +
//                         ((boxConstraints.maxWidth - width * 0.75) -
//                             ((boxConstraints.maxWidth - width * 0.75) / 2) *
//                                 -currentPageValue *
//                                 (pageLocation ? 9 : 1));
//
//                     var customizableCard = Positioned.directional(
//                       top: 24,
//                       bottom: 24,
//                       start: start,
//                       textDirection: TextDirection.ltr,
//                       child:  SizedBox(
//                         width: width * 0.67,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Stack(
//                             children: [
//                               Image.network(
//                                 widget.pages[i].mainImage!,
//                                 fit: BoxFit.cover,
//                                 height: 0.6.sh,
//                               ),
//                               Positioned(
//                                 right: 18,
//                                 bottom: 20,
//                                 child:  Row(
//                                   children: [
//                                     SizedBox(
//                                       height: 38.h,
//                                       width: 141.w,
//                                       child: CustomElevated(
//                                         borderRadius: 8.sp,
//                                         text: "Take a Look ",
//                                         press: () {
//                                           print("xxxxxxxxx");
//                                           MagicRouter.navigateTo(
//                                             page: TakeLookScreen(
//                                               id: "${widget.pages[i].id}",
//                                             ),
//                                           );
//                                         },
//                                         btnColor: ColorManager.mainColor,
//                                       ),
//                                     ),
//                                     8.horizontalSpace,
//                                     CircleAvatar(
//                                       radius: 20,
//                                       backgroundColor: ColorManager.blueColor,
//                                       child: const SvgIcon(
//                                         icon: AssetsStrings.out,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                     cards.add(customizableCard);
//                   }
//                   return Stack(children: cards);
//                 },
//               ),
//             ),
//             Positioned.fill(
//               child: PageView.builder(
//                 physics: const BouncingScrollPhysics(
//                   parent: AlwaysScrollableScrollPhysics(),
//                 ),
//                 controller: _pageController,
//                 itemCount: widget.pages.length,
//                 itemBuilder: (context, index) {
//                   return const SizedBox();
//                 },
//               ),
//             ),
//             const Positioned(
//               right: 25,
//               top: 30,
//               child: CircleAvatar(
//                 radius: 20,
//                 backgroundColor: Colors.black,
//                 child: SvgIcon(
//                   icon: AssetsStrings.favorite,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
