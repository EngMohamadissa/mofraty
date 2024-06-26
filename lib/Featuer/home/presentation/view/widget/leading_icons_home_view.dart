import 'package:eghyptproject/constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/styles.dart';
import '../../../../../core/utils/app_router.dart';

class AppBarHomeView extends StatelessWidget {
  const AppBarHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for the screen width
    double smallScreenBreakpoint =
        320.0; // Example breakpoint for small screens
    double largeScreenBreakpoint =
        600.0; // Example breakpoint for large screens
    double boxWidth;
    if (screenWidth <= smallScreenBreakpoint) {
      boxWidth = 30.0; // Smaller width for small screens
    } else if (screenWidth <= largeScreenBreakpoint) {
      boxWidth = 50.0; // Default width for medium screens
    } else {
      boxWidth = 80.0; // Larger width for large screens
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // IconButton(
        //   color: Colors.white,
        //   icon: const Icon(
        //     Icons.notifications,
        //   ),
        //   onPressed: () {
        //     GoRouter.of(context).push(AppRouter.kNotificationViewLocal);
        //   },
        // ),
        // IconButton(
        //   color: Colors.white,
        //   icon: const Icon(
        //     Icons.person,
        //   ),
        //   onPressed: () {
        //     GoRouter.of(context).push(AppRouter.kMyDataView);
        //   },
        // ),
        // IconButton(
        //   color: Colors.white,
        //   icon: const Icon(
        //     Icons.call_outlined,
        //   ),
        //   onPressed: () {},
        // ),
        // SizedBox(
        //   width: boxWidth,
        // ),
        const SizedBox(),
        const Spacer(),
        Center(
          child: Text(
            "موفرتي",
            style: Styles.textStyle24(context).copyWith(
                fontWeight: FontWeight.bold, color: kPrimaryColorwhit),
          ),
        ),
        const Spacer(),
        const SizedBox(),
      ],
    );
  }
}
