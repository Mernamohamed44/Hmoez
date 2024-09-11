import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 43,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Regular',
            ),
            dividerColor: Colors.transparent,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Regular',
            ),
            tabs: tabs,
          ),
        ),
      ],
    );
  }
}
