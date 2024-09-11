import 'package:flutter/material.dart';
import 'package:homez/core/theming/colors.dart';

class SweetNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BoxShadow>? boxShadow;
  final List<SweetNavBarItem> items;
  final LinearGradient? paddingGradientColor;
  final double? borderRadius;
  final double? height;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? paddingBackgroundColor;
  final bool? showUnselectedLabels;
  final bool? showSelectedLabels;

  const SweetNavBar({
    required this.currentIndex,
    required this.items,
    Key? key,
    this.onTap,
    this.borderRadius,
    this.height,
    this.boxShadow,
    this.padding,
    this.backgroundColor,
    this.showUnselectedLabels,
    this.showSelectedLabels,
    this.paddingBackgroundColor,
    this.paddingGradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paddingBackgroundColor,
        gradient: paddingGradientColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.mainColor,
          unselectedItemColor: Colors.grey,
          onTap: onTap,
          //backgroundColor: backgroundColor ?? Colors.white,
          showUnselectedLabels: showUnselectedLabels ?? false,
          selectedLabelStyle: TextStyle(color: ColorManager.bgColor),
          unselectedLabelStyle: TextStyle(color: ColorManager.bgColor),
          showSelectedLabels: showSelectedLabels ?? false,
          items: items.map((item) => item.toBottomNavigationBarItem()).toList(),
          currentIndex: currentIndex,
        ),
      ),
    );
  }

  static ShaderMask sweetIcon({
    required List<Color> iconColors,
    Alignment? begin,
    Alignment? end,
    required Widget icon,
  }) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        colors: iconColors,
        begin: begin ?? Alignment.topCenter,
        end: end ?? Alignment.bottomCenter,
      ).createShader(rect),
      child: icon,
    );
  }
}

class SweetNavBarItem {
  final Widget? sweetActive;
  final Widget sweetIcon;
  final Color? sweetBackground;
  final List<Color>? iconColors;
  final String? sweetLabel;
  final Alignment? begin;
  final bool isGradient;
  final Alignment? end;
  final String? sweetTooltip;

  SweetNavBarItem({
    this.iconColors,
    this.begin,
    this.end,
    this.isGradient = true,
    required this.sweetIcon,
    this.sweetActive,
    this.sweetBackground,
    this.sweetLabel,
    this.sweetTooltip,
  });

  Widget get activeIcon => isGradient
      ? gradientIcon(icon: sweetActive ?? sweetIcon)
      : sweetActive ?? sweetIcon;

  Widget get icon => isGradient ? gradientIcon(icon: sweetIcon) : sweetIcon;

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      label: sweetLabel,
      backgroundColor: sweetBackground,
      tooltip: sweetTooltip,
    );
  }

  Widget gradientIcon({required Widget icon}) {
    return SweetNavBar.sweetIcon(
      iconColors:
          iconColors ?? [ColorManager.blueColor, ColorManager.blueColor],
      icon: icon,
    );
  }
}
